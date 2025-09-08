class_name GridSpace extends Area2D

#TODO This should combine both the GridSpace and PieceSpace classes from the sandbox
# Make sure everything works once I get the grid itself working
signal add_new_piece(piece, location, player)
signal grab_neutral_piece(location, player)
signal clicked_on_space(location, player)

var is_root_node = false
var root_piece: Piece
var is_covered = false
#TODO Not sure if these variables are needed for anything, or if it's better to work with the Sprite2Ds directly
var grid_image: Texture2D
var piece_image: Texture2D
#var space_group = "Grid Spaces " + str(space_owner)

@export var location: Vector2i
@export var space_owner: Player

enum Player {PLAYER_1, PLAYER_2, UNOWNED}

func _ready() -> void:
	#space_group = "Grid Spaces " + str(space_owner)
	#print(space_group)
	#add_to_group(space_group)
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
		$PieceImage.z_index = 100
	var piece_points = new_piece.secondary_points
	for point in piece_points:
		if location == point:
			#print("covering " + str(location))
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
			$PieceImage.z_index = 1
		var piece_points = piece.secondary_points
		for point in piece_points:
			if location == point:
				#print("uncovering " + str(location))
				is_covered = false

#TODO Inventory is still a global, not sure if that's the right design atm
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("clicked on grid space " + str(location))
		clicked_on_space.emit(location, space_owner)
		
		#if space_owner == Player.UNOWNED and not Inventory.current_piece:
			#grab_neutral_piece.emit(location, Player.PLAYER_1)
		if not is_covered and Inventory.current_piece:
			print("adding new piece")
			# TODO PLAYER_1 is hardcoded for a click; this needs to change if MP becomes a thing
			add_new_piece.emit(Inventory.current_piece.duplicate(), location, Player.PLAYER_1)

func _to_string() -> String:
	return str(location)
