class_name GridSpace extends Area2D

#TODO This should combine both the GridSpace and PieceSpace classes from the sandbox
# Make sure everything works once I get the grid itself working
signal add_new_piece

var is_root_node = false
var root_piece: Piece
var is_covered = false
#TODO Not sure if these variables are needed for anything, or if it's better to work with the Sprite2Ds directly
var grid_image: Texture2D
var piece_image: Texture2D

@export var location: Vector2i

func _ready() -> void:
	add_to_group("Grid Spaces")
	grid_image = $SpaceImage.texture

# TODO is_covered might be redundant at this point--I'm not removing it now,
# but I need to reconsider it for the full implementation
func _on_add_new_piece(new_piece, piece_location):
	if piece_location == location:
		is_root_node = true
		root_piece = Inventory.current_piece
		piece_image = new_piece.image
		$PieceImage.texture = piece_image
		$PieceImage.position = new_piece.translation
		$PieceImage.rotation = new_piece.rotation
		$PieceImage.visible = true
	var piece_points = new_piece.secondary_points
	for point in piece_points:
		if location == point:
			print("covering " + str(location))
			is_covered = true

func remove_pieces(piece_array):
	for piece in piece_array:
		if piece.root_point_location == location:
			print(location)
			is_root_node = false
			root_piece = null
			piece_image = null
			$PieceImage.texture = null
			$PieceImage.visible = false
		var piece_points = piece.secondary_points
		for point in piece_points:
			if location == point:
				print("uncovering " + str(location))
				is_covered = false

#TODO Inventory is still a global, not sure if that's the right design atm
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("clicked on grid space " + str(location))
		if not is_covered and Inventory.current_piece:
			print("adding new piece")
			add_new_piece.emit(Inventory.current_piece.duplicate(), location)

func str():
	return str(location)
