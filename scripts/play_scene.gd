extends Node2D

# TODO very, very placeholder at this point;
# eventually this should handle stuff like victory conditions and moving from scene to scene

# TODO These should probably act like the grid spaces in grid to make them less hard-coded
func _on_send_garbage(num_garbage, sending_player) -> void:
	if sending_player == Inventory.Player.PLAYER_2:
		$Player1Grid.receive_garbage(num_garbage)
	elif sending_player == Inventory.Player.PLAYER_1:
		$Player2Grid.receive_garbage(num_garbage)


func _on_neutral_grid_get_neutral_piece(piece: Piece, player: Inventory.Player) -> void:
	if player == Inventory.Player.PLAYER_1:
		$Player1Grid.set_current_piece(piece)


func _on_neutral_grid_clicked_on_space(location: Variant, player: Variant) -> void:
	# TODO needs to connect down and finish this (and the other side of it)
	pass # Replace with function body.
