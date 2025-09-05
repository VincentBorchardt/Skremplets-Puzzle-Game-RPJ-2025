extends Node2D

# TODO very, very placeholder at this point;
# eventually this should handle stuff like victory conditions and moving from scene to scene

func _on_grid_removing_pieces(pieces, player) -> void:
	print("in _on_grid_removing_pieces")
	# TODO This should probably call all the powerup bars, and then they can check if it's relevant
	$PowerUpBar.convert_pieces(pieces, player)
