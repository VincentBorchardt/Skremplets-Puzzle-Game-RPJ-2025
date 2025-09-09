# TODO Consider making a play_grid class, a neutral_grid class already extends this
# also consider an ai_grid class
class_name Grid extends Node2D

signal removing_pieces
signal removing_special_pieces
signal set_current_piece(piece)
signal clicked_on_space(location, player)
signal start_ai_place

#TODO Should this create a grid dynamically? The most annoying part there is connecting the signals
@export var grid_x: int
@export var grid_y: int
@export var grid_owner: Inventory.Player
@export var background_image: Texture2D

var piece_list = PieceList.new()
var spaces_list = []

func _ready() -> void:
	spaces_list = $Spaces.get_children()
	for space in spaces_list:
		space.space_owner = grid_owner
	if background_image:
		$Background.texture = background_image


#TODO Check if the returns are needed in this function specifically beyond breaks
func add_new_piece(new_piece, new_location, player):
	print("in _on_grid_space_add_new_piece")
	if not is_legal_place(new_piece, new_location, player):
		return false
	else:
		place_piece(new_piece, new_location)
		set_current_piece.emit(null)
		try_to_clear_pieces()
		if player == Inventory.Player.PLAYER_1:
			start_ai_place.emit()
		return true

func _on_grid_space_clicked_on_space(location: Vector2i, player: Inventory.Player) -> void:
	clicked_on_space.emit(location, player)

func ensure_legal_piece(piece):
	var test_piece = piece.duplicate()
	for i in range(4):
		test_piece.rotate(i * TAU/4)
		for x in range(grid_x):
			for y in range(grid_y):
				if is_legal_place(test_piece, Vector2i(x, y), grid_owner):
					return true
	return false

func is_legal_place(new_piece, new_location, player):
	if player != grid_owner:
		#print("Not Player 1's Grid")
		return false
	if piece_list.has_overlaps(new_piece, new_location):
		return false
	for point in new_piece.secondary_points:
		var new_point = point + new_location
		if point_is_off_grid(new_point):
			#print(str(new_point) + " is off the grid")
			return false
	return true

func place_piece(new_piece, new_location):
	var piece_points = []
	new_piece.root_point_location = new_location
	for i in range(new_piece.secondary_points.size()):
		var point = new_piece.secondary_points[i] + new_location
		piece_points.append(point)
		new_piece.secondary_points[i] = point
	piece_list.add(new_piece, piece_points)
	for node in spaces_list:
		node._on_add_new_piece(new_piece, new_location)
	return true

# TODO should this be a generic place_random_place function? or should be in NeutralGrid only?
func place_garbage(num_garbage):
	for i in range (num_garbage):
		var new_garbage = load("res://resources/pieces/garbage_block.tres").duplicate()
		var num_tries = 0
		var failed_placement = true
		while failed_placement:
			failed_placement = false
			var rand_x = randi() % grid_x
			var rand_y = randi() % grid_y
			var rand_location = Vector2i(rand_x, rand_y)
			if is_legal_place(new_garbage, rand_location, grid_owner):
				place_piece(new_garbage, rand_location)
			else:
				num_tries = num_tries + 1
				if num_tries > 500:
					print("failed placing garbage")
					print(str(grid_owner) + " loses")
				else:
					failed_placement = true

func try_to_clear_pieces():
	var pieces_to_clear = piece_list.get_touching_pieces()
	if not pieces_to_clear.is_empty():
		print("removing pieces")
		#print(pieces_to_clear)
		removing_pieces.emit(pieces_to_clear, grid_owner)
		var special_pieces_to_clear = piece_list.get_special_touching_pieces(pieces_to_clear)
		#print(special_pieces_to_clear)
		if not special_pieces_to_clear.is_empty():
			removing_special_pieces.emit(special_pieces_to_clear, grid_owner)
		pieces_to_clear.append_array(special_pieces_to_clear)
		piece_list.remove_pieces(pieces_to_clear)
		for node in spaces_list:
			node.remove_pieces(pieces_to_clear)
		try_to_clear_pieces()

func point_is_off_grid(point):
	return point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y
