extends Node2D


func _on_grid_removing_pieces(pieces, player) -> void:
	print("in _on_grid_removing_pieces")
	# TODO This should probably call all the powerup bars, and then they can check if it's relevant
	$PowerUpBar.convert_pieces(pieces, player)


func _on_grid_removing_special_pieces(pieces, player) -> void:
	pass # Replace with function body.

func send_garbage(num_garbage):
	$PlayGrid.place_garbage(num_garbage)
