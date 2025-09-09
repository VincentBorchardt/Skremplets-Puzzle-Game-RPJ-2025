class_name PieceList extends Resource

# TODO figure out if this should really be a dictionary or something else
# one of the points of this class is to hide that implementation detail
var list = {}

func add(piece, points):
	print("adding " + str(piece) + " to piece_list")
	if not list.has(piece):
		list[piece] = points

func remove_pieces(pieces_to_clear):
	for piece in pieces_to_clear:
		list.erase(piece)

func size():
	return list.size()

func get_piece_at_location(location):
	for piece in list:
		print(location)
		print(piece)
		print(list[piece])
		if list[piece].has(location):
			return piece
	return null

func get_piece_at_index(index):
	return list.keys()[index]

func has_overlaps(new_piece, new_location):
	for piece in list:
		for point in new_piece.secondary_points:
			if list[piece].has(point + new_location):
				print(str(new_location) + " is already covered")
				return true

func get_special_touching_pieces(clearing_pieces):
	var special_to_be_cleared = []
	for piece1 in list:
		if piece1.type == Inventory.Type.GARBAGE or piece1.type == Inventory.Type.POWERUP:
			for piece2 in clearing_pieces:
				if piece2.is_special_touching(piece1):
					special_to_be_cleared.append(piece1)
	return special_to_be_cleared

func get_touching_pieces():
	print("in check_pieces_touching")
	var placed_pieces = list.keys()
	var num_pieces = placed_pieces.size()
	for i in range(num_pieces):
		var piece_1 = placed_pieces[i]
		if not piece_1.should_not_be_matched():
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
	var placed_pieces = list.keys()
	var num_pieces = placed_pieces.size()
	var found_new_piece = true
	while(found_new_piece):
		found_new_piece = false
		for i in range(num_pieces):
			var new_piece = placed_pieces[i]
			if not pieces_to_check.has(new_piece):
				for piece in pieces_to_check:
					if piece.is_touching(new_piece) and not pieces_to_check.has(new_piece):
						pieces_to_check.append(new_piece)
						found_new_piece = true
	return pieces_to_check

func _to_string() -> String:
	return str(list)
