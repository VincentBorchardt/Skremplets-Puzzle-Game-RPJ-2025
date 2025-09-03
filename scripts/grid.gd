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
var piece_list = PieceList.new()

#TODO This needs to be updated for the final project and not duplicated everywhere
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, WILD, NONE}

func _ready() -> void:
	grid_group = "Grid Spaces " + str(grid_owner)
	print(grid_group)
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
	if piece_list.has_overlaps(new_piece, new_location):
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
	piece_list.add(new_piece, piece_points)
	#print(get_tree().get_nodes_in_group(grid_group).size())
	for node in get_tree().get_nodes_in_group(grid_group):
		node._on_add_new_piece(new_piece, new_location)
	Inventory.current_piece = null
	try_to_clear_pieces()
	return true

func try_to_clear_pieces():
	var pieces_to_clear = piece_list.get_touching_pieces()
	if not pieces_to_clear.is_empty():
		print("removing pieces")
		piece_list.remove_pieces(pieces_to_clear)
		for node in get_tree().get_nodes_in_group(grid_group):
			node.remove_pieces(pieces_to_clear)
		try_to_clear_pieces()

func point_is_off_grid(point):
	# TODO This should be removed and point to the piece off_grid function
	return point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y
