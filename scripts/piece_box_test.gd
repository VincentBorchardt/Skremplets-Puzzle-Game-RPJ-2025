extends VBoxContainer

signal send_garbage

func _on_red_line_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/red_four_line.tres").duplicate()

func _on_yellow_square_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/yellow_four_square.tres").duplicate()

func _on_blue_t_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/blue_four_t.tres").duplicate()

func _on_green_bottle_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/green_three_three_bottle.tres").duplicate()

func _on_rotate_cw_button_pressed() -> void:
	Inventory.rotate_current_piece(TAU/4)

func _on_rotate_ccw_button_pressed() -> void:
	Inventory.rotate_current_piece(-TAU/4)

func _on_place_player_garbage_pressed() -> void:
	send_garbage.emit(3, Inventory.Player.PLAYER_2)
