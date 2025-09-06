extends Node2D

# TODO very, very placeholder at this point;
# eventually this should handle stuff like victory conditions and moving from scene to scene
enum Player {PLAYER_1, PLAYER_2, UNOWNED}

func _on_piece_box_test_send_garbage(num_garbage, player) -> void:
	if player == Player.PLAYER_1:
		$Player1Grid.send_garbage(num_garbage)
