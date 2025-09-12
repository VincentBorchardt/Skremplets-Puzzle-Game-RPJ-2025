class_name BasePlayArea extends Node2D

signal send_pieces(piece, num_pieces, sending_player)
signal loss_condition(losing_player, losing_character)

#TODO put an inventory in here, then rework everything inventory-wise to work with signals
var current_piece: Piece:
	set(piece):
		current_piece = piece
		$PreviewBox.current_piece_changed(piece)
		if piece != null:
			if not $PlayGrid.ensure_legal_piece(piece):
				print(str(grid_owner) + " loses")
				loss_condition.emit(grid_owner, character)

var garbage_piece = preload("res://resources/pieces/garbage_block.tres").duplicate()

@export var character: Character
@export var grid_owner: Inventory.Player

func set_current_piece(piece):
	current_piece = piece

func rotate_current_piece(rotation_angle):
	if current_piece:
		current_piece.rotate(rotation_angle)
		$PreviewBox.current_piece_changed(current_piece)

func _on_grid_removing_pieces(pieces, player) -> void:
	print("in _on_grid_removing_pieces")
	var total_spaces = convert_pieces(pieces)
	var total_garbage = calculate_garbage(total_spaces)
	send_pieces.emit(garbage_piece.duplicate(), total_garbage, grid_owner)
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
	#TODO check if the character is depowered or not here
	match character:
		preload("res://resources/characters/grymmt_dundle.tres"):
			var powerup = preload("res://resources/pieces/apple_power_up.tres").duplicate()
			$PlayGrid.place_multiple_pieces(powerup, 2)
		preload("res://resources/characters/orchk.tres"):
			var powerup = preload("res://resources/pieces/sound_at_two_power_up.tres")
			send_pieces.emit(powerup, 2, grid_owner)
		_:
			print("currently not implemented")

func _on_grid_activate_special_pieces(pieces, player) -> void:
	# TODO this will do things when you clear powerups
	for piece in pieces:
		match piece.power_up_type:
			Inventory.PowerUpType.GRYMMT:
				send_pieces.emit(garbage_piece.duplicate(), 2, grid_owner)
				$PowerUpBar.add_to_bar(3)
			_:
				pass

func receive_pieces(piece, num_pieces):
	$PlayGrid.place_multiple_pieces(piece, num_pieces)
