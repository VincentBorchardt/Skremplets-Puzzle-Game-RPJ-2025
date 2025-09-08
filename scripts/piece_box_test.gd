extends VBoxContainer

signal send_garbage(num_garbage, sending_player)
signal get_neutral_piece(piece, player)

func _on_red_line_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/red_four_line.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_yellow_square_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/yellow_four_square.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_blue_t_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/blue_four_t.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_green_bottle_button_pressed() -> void:
	get_neutral_piece.emit(preload("res://resources/pieces/green_three_three_bottle.tres").duplicate(), Inventory.Player.PLAYER_1)

func _on_place_player_garbage_pressed() -> void:
	send_garbage.emit(3, Inventory.Player.PLAYER_2)
