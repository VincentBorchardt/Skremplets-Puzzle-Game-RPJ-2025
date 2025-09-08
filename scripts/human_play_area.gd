class_name HumanPlayArea extends BasePlayArea


func _on_play_grid_clicked_on_space(location: Variant, player: Variant) -> void:
	if current_piece:
		$PlayGrid._on_grid_space_add_new_piece(current_piece.duplicate(), location, player)
