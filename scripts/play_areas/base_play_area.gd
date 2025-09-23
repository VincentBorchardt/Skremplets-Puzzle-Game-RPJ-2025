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
			$PlayGrid.spread_nightmare()

@export var character: Character:
	set(new_character):
		character = new_character
		match grid_owner:
			Inventory.Player.PLAYER_1:
				$CharacterPortrait.texture = new_character.player_1_portrait
				$CharacterPortrait.position = new_character.player_1_position
			Inventory.Player.PLAYER_2:
				$CharacterPortrait.texture = new_character.player_2_portrait
				$CharacterPortrait.position = new_character.player_2_position

var garbage_piece = Pieces.garbage_block.duplicate()


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
	# TODO match on powerup type in the character
	var powerup
	if character.has_sweater:
		var num_garbage = $PlayGrid.gather_and_remove_garbage()
		send_pieces.emit(garbage_piece.duplicate(), num_garbage, grid_owner)
	elif not character.depowered:
		match character:
			preload("res://resources/characters/grymmt_dundle.tres"):
				powerup = Pieces.apple_power_up.duplicate()
				$PlayGrid.place_multiple_pieces(powerup, 2)
			preload("res://resources/characters/orchk.tres"):
				powerup = Pieces.sound_at_two_powerup.duplicate()
				send_pieces.emit(powerup, 2, grid_owner)
			preload("res://resources/characters/pastoriche.tres"):
				powerup = Pieces.nightmare_power_up.duplicate()
				send_pieces.emit(powerup, 1, grid_owner)
			preload("res://resources/characters/boyhowdy.tres"):
				# TODO This is a boring power, though it "synergizes" with the sweater
				send_pieces.emit(garbage_piece.duplicate(), 5, grid_owner)
			_:
				print("currently not implemented")

func _on_grid_activate_special_pieces(pieces, player) -> void:
	for piece in pieces:
		match piece.power_up_type:
			Pieces.PowerUpType.GRYMMT:
				send_pieces.emit(garbage_piece.duplicate(), 2, grid_owner)
				$PowerUpBar.add_to_bar(3)
			Pieces.PowerUpType.SWEATER:
				character.has_sweater = true
				if grid_owner == Inventory.Player.PLAYER_1:
					Inventory.player_character.has_sweater = true
				elif grid_owner == Inventory.Player.PLAYER_2:
					Inventory.opponent_character.has_sweater = true
				# TODO Change the grid picture, assuming I get the asset for it
			_:
				pass

func receive_pieces(piece, num_pieces):
	$PlayGrid.place_multiple_pieces(piece, num_pieces)
