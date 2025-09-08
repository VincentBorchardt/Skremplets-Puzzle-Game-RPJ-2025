class_name HumanPlayArea extends BasePlayArea

func _on_play_grid_clicked_on_space(location: Variant, player: Variant) -> void:
	if current_piece:
		$PlayGrid.add_new_piece(current_piece.duplicate(), location, player)

func _on_rotate_cw_button_pressed() -> void:
	rotate_current_piece(TAU/4)

func _on_rotate_ccw_button_pressed() -> void:
	rotate_current_piece(-TAU/4)
