extends Node2D

# TODO very, very placeholder at this point;
# eventually this should handle stuff like victory conditions and moving from scene to scene

# TODO Change most of these to matches based on the given player

# TODO These should probably act like the grid spaces in grid to make them less hard-coded
func _on_send_pieces(piece, num_pieces, sending_player) -> void:
	if sending_player == Inventory.Player.PLAYER_2:
		$Player1Grid.receive_pieces(piece, num_pieces)
	elif sending_player == Inventory.Player.PLAYER_1:
		$Player2Grid.receive_pieces(piece, num_pieces)

func _on_neutral_grid_get_neutral_piece(piece: Piece, player: Inventory.Player) -> void:
	if player == Inventory.Player.PLAYER_1:
		$Player1Grid.set_current_piece(piece)
	elif player == Inventory.Player.PLAYER_2:
		$Player2Grid.set_current_piece(piece)

func _on_neutral_grid_clicked_on_space(location: Variant, player: Variant) -> void:
	# TODO going to fix as Player 1 for now, might need to add Player 2 support, or use a different path
	# TODO Not checking Inventory is null, won't need to at the end obviously, but might cause problems now
	if not $Player1Grid.current_piece:
		# TODO change this name if this is how I decide to do it
		$NeutralGrid.grab_neutral_piece(location, Inventory.Player.PLAYER_1)

func _on_neutral_grid_start_ai_pick(piece_list, player) -> void:
	#print("in _on_neutral_grid_start_ai_pick")
	var preferred_piece = $Player2Grid.get_preferred_piece(piece_list)
	$NeutralGrid.grab_neutral_piece(preferred_piece.root_point_location, player)

func _on_player_1_grid_start_ai_place() -> void:
	$Player2Grid.start_ai_place()


func _on_grid_loss_condition(losing_player: Variant, losing_character: Variant) -> void:
	$CanvasLayer/LoserLabel.text = losing_character.name + " Loses!"
	$CanvasLayer.visible = true


func _on_title_screen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
