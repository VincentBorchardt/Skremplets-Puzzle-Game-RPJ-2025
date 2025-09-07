extends Node2D

# TODO very, very placeholder at this point;
# eventually this should handle stuff like victory conditions and moving from scene to scene
#enum Player {PLAYER_1, PLAYER_2, UNOWNED}

func _on_send_garbage(num_garbage, sending_player) -> void:
	if sending_player == Inventory.Player.PLAYER_2:
		$Player1Grid.receive_garbage(num_garbage)
	elif sending_player == Inventory.Player.PLAYER_1:
		$Player2Grid.receive_garbage(num_garbage)
