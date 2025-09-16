class_name GridSpace extends Area2D

signal clicked_on_space(location, player)

var is_root_node = false
var root_piece: Piece
var is_covered = false

@export var location: Vector2i
@export var space_owner: Inventory.Player

func _ready() -> void:
	pass

# TODO is_covered might be redundant at this point--I'm not removing it now,
# but I need to reconsider it for the full implementation
func _on_add_new_piece(new_piece, piece_location):
	if piece_location == location:
		is_root_node = true
		root_piece = new_piece
		$PieceImage.texture = new_piece.image
		$PieceImage.position = new_piece.translation
		$PieceImage.rotation = new_piece.rotation
		$PieceImage.visible = true
		$PieceImage.z_index = 100
	var piece_points = new_piece.secondary_points
	for point in piece_points:
		if location == point:
			#print("covering " + str(location))
			is_covered = true

func remove_pieces(piece_array):
	for piece in piece_array:
		if piece.root_point_location == location:
			print("removing piece at " + str(location))
			is_root_node = false
			root_piece = null
			$PieceImage.texture = null
			$PieceImage.visible = false
			$PieceImage.z_index = 1
		var piece_points = piece.secondary_points
		for point in piece_points:
			if location == point:
				#print("uncovering " + str(location))
				is_covered = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("clicked on grid space " + str(location))
		clicked_on_space.emit(location, space_owner)

func _to_string() -> String:
	return str(location)
