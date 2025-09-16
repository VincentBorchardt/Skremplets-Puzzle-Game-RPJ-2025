class_name NeutralGrid extends Grid

signal get_neutral_piece(piece, player)
signal start_ai_pick(piece_list, player)

var piece_storage: Array[Piece]

func _ready() -> void:
	super()


func grab_neutral_piece(location, player) -> void:
	#print("in _on_grid_space_grab_neutral_piece")
	#print("grabbing piece at " + str(location))
	var piece = piece_list.get_piece_at_location(location)
	if piece:
		var root = piece.root_point_location
		var pieces_to_clear = [piece]
		piece_list.remove_pieces(pieces_to_clear)
		for node in spaces_list:
			node.remove_pieces(pieces_to_clear)
		piece.pick_up_piece(player)
		get_neutral_piece.emit(piece, player)
		# TODO hardcoding Human versus AI here
		if player == Inventory.Player.PLAYER_1:
			start_ai_pick.emit(piece_list, Inventory.Player.PLAYER_2)
			$RepopulateTimer.start(0.5)

func populate_neutral_grid(pieces_to_re_add):
	var current_y = 0
	# TODO lots of duplicated code here I don't like
	for old_piece in pieces_to_re_add:
		var piece = old_piece.duplicate()
		if piece.x_length < piece.y_length:
			piece.rotate(-TAU/4)
		var min_length = piece.min_length()
		var mod_y = current_y + -piece.min_y()
		var location = Vector2i(2, mod_y)
		place_piece(piece, location)
		current_y = current_y + min_length
	while current_y < grid_y:
		var index = randi() % piece_storage.size()
		var piece = piece_storage[index].duplicate()
		if piece.x_length < piece.y_length:
			piece.rotate(-TAU/4)
		var min_length = piece.min_length()
		if current_y + min_length > grid_y:
			current_y = current_y + min_length
			break
		var mod_y = current_y + -piece.min_y()
		var location = Vector2i(2, mod_y)
		place_piece(piece, location)
		current_y = current_y + min_length

# TODO I want to drop a piece off the grid each time, but that is more complicated
# I also want to reverse the direction (right now everything moves up), but that's hard,
# especially without entirely rebuilding how I do grids
func repopulate_neutral_grid():
	var pieces_to_re_add = []
	var old_pieces = piece_list.get_pieces().duplicate()
	piece_list.remove_pieces(old_pieces)
	for node in spaces_list:
		node.remove_pieces(old_pieces)
	for piece in old_pieces:
		piece.pick_up_piece(grid_owner)
		pieces_to_re_add.append(piece)
	populate_neutral_grid(pieces_to_re_add)


func _on_repopulate_timer_timeout() -> void:
	repopulate_neutral_grid()
