# TODO Consider making a play_grid class, a neutral_grid class already extends this
# also consider an ai_grid class
class_name Grid extends Node2D

signal removing_pieces
signal activate_special_pieces(pieces, player)
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
	#print("in _on_grid_space_add_new_piece")
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
	if get_legal_piece(piece):
		return true
	else:
		return false

func get_legal_piece(piece):
	var test_piece = piece.duplicate()
	for i in range(4):
		test_piece.rotate(TAU/4)
		for x in range(grid_x):
			for y in range(grid_y):
				var location = Vector2i(x, y)
				if is_legal_place(test_piece, location, grid_owner):
					return location
	return null

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
func place_multiple_pieces(piece, num_pieces):
	for i in range (num_pieces):
		var new_piece = piece.duplicate()
		var num_tries = 0
		var failed_placement = true
		while failed_placement:
			failed_placement = false
			var rand_x = randi() % grid_x
			var rand_y = randi() % grid_y
			var rand_location = Vector2i(rand_x, rand_y)
			if is_legal_place(new_piece, rand_location, grid_owner):
				place_piece(new_piece, rand_location)
			else:
				num_tries = num_tries + 1
				if num_tries > 500:
					print("failed placing piece")
					print(str(grid_owner) + " loses")
				else:
					failed_placement = true

func try_to_clear_pieces():
	var pieces_to_clear = piece_list.get_touching_pieces()
	if not pieces_to_clear.is_empty():
		$ClearPiecesTimer.start_with_piece_list(pieces_to_clear)

func check_special_pieces(pieces_to_check):
	var pieces_to_clear = []
	for piece in pieces_to_check:
		match piece.power_up_type:
			Inventory.PowerUpType.ORCHK_TWO:
				var location = piece.root_point_location
				piece_list.remove_pieces([piece])
				for node in spaces_list:
					node.remove_pieces([piece])
				var new_piece = preload("res://resources/pieces/powerup/sound_at_one_power_up.tres").duplicate()
				place_piece(new_piece, location)
			_:
				pieces_to_clear.append(piece)
	return pieces_to_clear

func _on_clear_pieces_timer_timeout_with_piece_list(pieces_to_clear) -> void:
	print("removing pieces")
	removing_pieces.emit(pieces_to_clear, grid_owner)
	var special_pieces_to_check = piece_list.get_special_touching_pieces(pieces_to_clear)
	var special_pieces_to_clear = []
	if not special_pieces_to_check.is_empty():
		activate_special_pieces.emit(special_pieces_to_check, grid_owner)
		special_pieces_to_clear = check_special_pieces(special_pieces_to_check)
	pieces_to_clear.append_array(special_pieces_to_clear)
	piece_list.remove_pieces(pieces_to_clear)
	for node in spaces_list:
		node.remove_pieces(pieces_to_clear)
	try_to_clear_pieces()

func spread_nightmare():
	var nightmare_pieces = []
	for piece in piece_list.get_pieces():
		if piece.power_up_type == Inventory.PowerUpType.PASTORICHE:
			nightmare_pieces.append(piece.duplicate())
	if not nightmare_pieces.is_empty():
		nightmare_pieces.shuffle()
		for piece in nightmare_pieces:
			var adjacent_points = piece.get_adjacent_points()
			piece.pick_up_piece(grid_owner)
			var legal_points = []
			for point in adjacent_points:
				if is_legal_place(piece, point, grid_owner):
					legal_points.append(point)
			if not legal_points.is_empty():
				var index = randi() % legal_points.size()
				place_piece(piece, legal_points[index])
				return

func point_is_off_grid(point):
	return point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y
