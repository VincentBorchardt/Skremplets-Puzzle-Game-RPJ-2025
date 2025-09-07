class_name Grid extends Node2D

signal removing_pieces
signal removing_special_pieces

#TODO Should this create a grid dynamically? The most annoying part there is connecting the signals
@export var grid_x: int
@export var grid_y: int
@export var grid_owner: Player
@export var background_image: Texture2D

var piece_list = PieceList.new()
var spaces_list = []

# TODO This is a temporary hack to make neutral grids work in a basic form
# This should probably be in a global, or maybe tied to the specific level if/when they get implemented
var piece_storage = ["res://resources/pieces/blue_four_t.tres", "res://resources/pieces/red_four_line.tres", "res://resources/pieces/yellow_four_square.tres"]

#TODO This needs to be updated for the final project and not duplicated everywhere
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
#enum Type {RED, BLUE, YELLOW, GREEN, GARBAGE, POWERUP, WILD, NONE}

func _ready() -> void:
	spaces_list = $Spaces.get_children()
	#print(spaces_list)
	for space in spaces_list:
		space.space_owner = grid_owner
	if background_image:
		$Background.texture = background_image
	if grid_owner == Player.UNOWNED:
		print("Populating Neutral Grid")
		populate_neutral_grid()

#TODO Check if the returns are needed in this function specifically beyond breaks
func _on_grid_space_add_new_piece(new_piece, new_location, player):
	print("in _on_grid_space_add_new_piece")
	if not is_legal_place(new_piece, new_location, player):
		return false
	else:
		place_piece(new_piece, new_location)
		Inventory.current_piece = null
		try_to_clear_pieces()
		return true

func _on_grid_space_grab_neutral_piece(location, player) -> void:
	#print("in _on_grid_space_grab_neutral_piece")
	var piece = piece_list.get_piece_at_location(location)
	if piece:
		var pieces_to_clear = [piece]
		piece_list.remove_pieces(pieces_to_clear)
		for node in spaces_list:
			node.remove_pieces(pieces_to_clear)
		piece.pick_up_piece(player)
		Inventory.current_piece = piece

func is_legal_place(new_piece, new_location, player):
	if player != grid_owner:
		print("Not Player 1's Grid")
		return false
	if piece_list.has_overlaps(new_piece, new_location):
		return false
	for point in new_piece.secondary_points:
		var new_point = point + new_location
		if point_is_off_grid(new_point):
			print(str(new_point) + " is off the grid")
			return false
	return true

func place_piece(new_piece, new_location):
	# This is the actual modifying the piece and adding it, since it's good now
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
				if num_tries > 50:
					print("failed placing garbage")
				else:
					failed_placement = true

func try_to_clear_pieces():
	var pieces_to_clear = piece_list.get_touching_pieces()
	if not pieces_to_clear.is_empty():
		print("removing pieces")
		print(pieces_to_clear)
		removing_pieces.emit(pieces_to_clear, grid_owner)
		var special_pieces_to_clear = piece_list.get_special_touching_pieces(pieces_to_clear)
		print(special_pieces_to_clear)
		if not special_pieces_to_clear.is_empty():
			removing_special_pieces.emit(special_pieces_to_clear, grid_owner)
		pieces_to_clear.append_array(special_pieces_to_clear)
		piece_list.remove_pieces(pieces_to_clear)
		for node in spaces_list:
			node.remove_pieces(pieces_to_clear)
		try_to_clear_pieces()

func point_is_off_grid(point):
	# TODO This should be removed and point to the piece off_grid function?
	return point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y

# TODO THIS IS EXTREMELY HARDCODED FOR NOW
func populate_neutral_grid():
	for i in range(5):
		var index = randi() % 3
		var piece = load(piece_storage[index]).duplicate()
		var location = Vector2i(((2 * i) + 1), 1)
		# TODO This doesn't check if the space is legal, it shouldn't in this hack but likely will eventually
		place_piece(piece, location)
	#print(piece_list)
