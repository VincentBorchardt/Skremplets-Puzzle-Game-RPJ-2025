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
