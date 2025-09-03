extends VBoxContainer

func _on_red_line_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/red_four_line.tres").duplicate()

func _on_yellow_square_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/yellow_four_square.tres").duplicate()

func _on_blue_t_button_pressed() -> void:
	Inventory.current_piece = preload("res://resources/pieces/blue_four_t.tres").duplicate()

func _on_rotate_cw_button_pressed() -> void:
	Inventory.rotate_current_piece(TAU/4)

func _on_rotate_ccw_button_pressed() -> void:
	Inventory.rotate_current_piece(-TAU/4)
