extends VBoxContainer

signal send_pieces(piece, num_pieces, sending_player)
signal get_neutral_piece(piece, player)

func _on_red_line_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/red/red_four_line.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_yellow_square_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/yellow/yellow_four_square.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_blue_t_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/blue/blue_four_t.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_green_bottle_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/green/green_three_three_bottle.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_place_player_garbage_pressed() -> void:
	send_pieces.emit(preload("res://resources/pieces/garbage/garbage_block.tres").duplicate(), 3, Inventory.Player.PLAYER_2)

func _on_place_player_sound_pressed() -> void:
	send_pieces.emit(preload("res://resources/pieces/powerup/sound_at_two_power_up.tres").duplicate(), 2, Inventory.Player.PLAYER_2)
