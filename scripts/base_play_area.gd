class_name BasePlayArea extends Node2D

signal send_garbage(num_garbage, sending_player)

#TODO put an inventory in here, then rework everything inventory-wise to work with signals
var current_piece: Piece

@export var grid_owner: Inventory.Player

func set_current_piece(piece):
	current_piece = piece
	# TODO This is temporary to make sure things work as I slowly decouple things
	#Inventory.current_piece = piece

func _on_grid_removing_pieces(pieces, player) -> void:
	print("in _on_grid_removing_pieces")
	var total_spaces = convert_pieces(pieces)
	var total_garbage = calculate_garbage(total_spaces)
	send_garbage.emit(total_garbage, grid_owner)
	$PowerUpBar.add_to_bar(total_spaces)

func convert_pieces(pieces):
	print("in convert_pieces")
	#print(pieces)
	var total_spaces = 0
	for piece in pieces:
		var piece_spaces = piece.secondary_points.size()
		total_spaces = total_spaces + piece_spaces
	return total_spaces

func calculate_garbage(spaces):
	print("in_calculate garbage with " + str(spaces) + " spaces")
	match spaces:
		spaces when spaces < 10:
			return 0
		spaces when spaces >= 10 and spaces < 15:
			return 1
		spaces when spaces >= 15 and spaces < 18:
			return 2
		spaces when spaces >= 18 and spaces < 20:
			return 3
		spaces when spaces >= 20:
			return 4 + (spaces - 20)
		_:
			print("default case in calculate_garbage shouldn't happen")
			return 0

func _on_power_up_bar_activate_powerup() -> void:
	print("activating powerup for " + str(grid_owner))
	# TODO This is going to be hardcoded to Grymmt's apples for now

func _on_grid_removing_special_pieces(pieces, player) -> void:
	pass # Replace with function body.

func receive_garbage(num_garbage):
	$PlayGrid.place_garbage(num_garbage)
