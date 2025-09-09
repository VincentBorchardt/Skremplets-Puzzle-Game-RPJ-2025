class_name AIPlayArea extends BasePlayArea

func get_preferred_piece(neutral_piece_list):
	# TODO This is a simple algorithm to start, ideally we should change it by character
	# Boyhowdy will also want to know more things
	match character.ai_picking_pattern:
		Inventory.AIPickingPattern.RANDOM:
			return pick_random_piece(neutral_piece_list)

func pick_random_piece(neutral_piece_list):
	var index = randi() % neutral_piece_list.size()
	var piece = neutral_piece_list.get_piece_at_index(index)
	return piece

func start_ai_place():
	var piece_list = $PlayGrid.piece_list
	match character.ai_placement_pattern:
		Inventory.AIPlacementPattern.RANDOM_MATCHING:
			if piece_list.is_empty():
				place_fully_random_piece(0)
			else:
				place_selective_piece(piece_list)

func place_fully_random_piece(num_of_failures):
	# TODO turn this into a while loop instead of recursion?
	#print("placing fully random piece")
	var rand_space = randi() % ($PlayGrid.grid_x * $PlayGrid.grid_y)
	var rand_coord = Vector2i(rand_space % $PlayGrid.grid_x, floori(rand_space / $PlayGrid.grid_y))
	var rand_rotation = randi() % 4
	#print("attempting to place piece at " + str(rand_coord) + " with " + str(rand_rotation) + " rotations")
	rotate_current_piece(rand_rotation * (TAU / 4))
	if $PlayGrid.add_new_piece(current_piece, rand_coord, grid_owner):
		print("successful adding piece")
		return true
	else:
		var new_failures = num_of_failures + 1
		#print("Failed placing piece " + str(new_failures) + " times")
		if new_failures > 500:
			print("Giving up")
			return false
		else:
			return place_fully_random_piece(new_failures)

func place_selective_piece(piece_dict):
	for piece in piece_dict.get_pieces():
		#print(piece)
		#print(current_piece)
		if piece.type == current_piece.type:
			if try_to_place_connecting_piece(piece, 0):
				print("successful placing selective piece")
				return true
	print("failed placing selective piece")
	return place_fully_random_piece(0)

func try_to_place_connecting_piece(piece, num_of_failures) -> bool:
	var rand_space = randi() % ($PlayGrid.grid_x * $PlayGrid.grid_y)
	var rand_coord = Vector2i(rand_space % $PlayGrid.grid_x, floori(rand_space / $PlayGrid.grid_y))
	var rand_rotation = randi() % 4
	rotate_current_piece(rand_rotation * (TAU / 4))
	var piece_attempt = current_piece.duplicate()
	for i in range(piece_attempt.secondary_points.size()):
		var point = piece_attempt.secondary_points[i]
		piece_attempt.secondary_points[i] = point + rand_coord
	if piece_attempt.points_on_grid($PlayGrid.grid_x, $PlayGrid.grid_y):
		for point in piece_attempt.secondary_points:
			if piece.get_adjacent_points().has(point):
				if $PlayGrid.add_new_piece(current_piece, rand_coord, grid_owner):
					print("successful adding connecting piece")
					return true
	var new_failures = num_of_failures + 1
	#print("Failed placing piece " + str(new_failures) + " times")
	if new_failures > 500:
		print("Giving up")
		return false
	else:
		return try_to_place_connecting_piece(piece, new_failures)
