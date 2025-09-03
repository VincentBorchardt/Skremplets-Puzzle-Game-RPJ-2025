class_name Grid extends Node2D

# TODO This is hardcoded based on a specific string that has to be the same in Grid and GridSpace
# Smells very bad
var grid_group = "Grid Spaces " + str(grid_owner)

#TODO Should this create a grid dynamically? The most annoying part there is connecting the signals
@export var grid_x: int
@export var grid_y: int
@export var grid_owner: Player

#TODO This should be its own class with helper methods (presumably that's a resource?)
# Stuff like "get all the red pieces" or "get all the spaces next to a given piece"
var piece_dict = {}

#TODO This needs to be updated for the final project and not duplicated everywhere
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, WILD, NONE}

func _ready() -> void:
	if grid_owner == Player.UNOWNED:
		pass

#TODO Check if the returns are needed in this function specifically
func _on_grid_space_add_new_piece(new_piece, new_location, player):
	print("in _on_grid_space_add_new_piece")
	print(grid_owner)
	print(str(new_location))
	if player != grid_owner:
		print("Not Player 1's Grid")
		return false
	for piece in piece_dict:
		for point in new_piece.secondary_points:
			if piece_dict[piece].has(point + new_location):
				print(str(new_location) + " is already covered")
				return false
	var piece_points = []
	for point in new_piece.secondary_points:
		var new_point = point + new_location
		if point_is_off_grid(new_point):
			print(str(new_point) + " is off the grid")
			return false
		else:
			piece_points.append(new_point)
	
	# This is the actual modifying the piece and adding it, since it's good now
	new_piece.root_point_location = new_location
	for i in range(new_piece.secondary_points.size()):
		var point = new_piece.secondary_points[i]
		new_piece.secondary_points[i] = point + new_location
	piece_dict[new_piece] = piece_points
	for node in get_tree().get_nodes_in_group("Grid Spaces"):
		node._on_add_new_piece(new_piece, new_location)
	Inventory.current_piece = null
	try_to_clear_pieces()
	return true

func try_to_clear_pieces():
	var pieces_to_clear = check_pieces_touching()
	if not pieces_to_clear.is_empty():
		print("removing pieces")
		for piece in pieces_to_clear:
			piece_dict.erase(piece)
		for node in get_tree().get_nodes_in_group("Grid Spaces"):
			node.remove_pieces(pieces_to_clear)
		try_to_clear_pieces()

func point_is_off_grid(point):
	# TODO This should be removed and point to the piece off_grid function
	return point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y


func check_pieces_touching():
	print("in check_pieces_touching")
	var placed_pieces = piece_dict.keys()
	var num_pieces = placed_pieces.size()
	for i in range(num_pieces):
		var piece_1 = placed_pieces[i]
		if piece_1.type != Type.WILD:
			for j in range(num_pieces):
				var piece_2 = placed_pieces[j]
				if piece_1.is_touching(piece_2):
					var initial_pair = [piece_1, piece_2]
					var pieces_to_check = extended_piece_touching_check(initial_pair)
					if pieces_to_check.size() >= 3:
						return pieces_to_check
	return []

func extended_piece_touching_check(initial_pair):
	print("in extended_piece_touching_check")
	var pieces_to_check = initial_pair.duplicate()
	var placed_pieces = piece_dict.keys()
	var num_pieces = placed_pieces.size()
	var found_new_piece = true
	while(found_new_piece):
		found_new_piece = false
		for i in range(num_pieces):
			var new_piece = placed_pieces[i]
			if not pieces_to_check.has(new_piece):
				for piece in pieces_to_check:
					if piece.is_touching(new_piece):
						pieces_to_check.append(new_piece)
						found_new_piece = true
	return pieces_to_check
