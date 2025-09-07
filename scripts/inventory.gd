extends Node

# TODO Determine whether this should be a global singleton or something else
# Global singleton works if we're going to differentiate player/AI, but I want MP to be a possibility
signal current_piece_changed

# TODO putting this here since it should be a singleton somewhere, and it'll help with debugging
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, GREEN, PURPLE, GARBAGE, POWERUP, WILD, NONE}

var current_piece = null:
	set(piece):
		current_piece = piece
		current_piece_changed.emit(piece)

func rotate_current_piece(rotation_angle):
	if current_piece:
		current_piece.rotate(rotation_angle)
		current_piece_changed.emit(current_piece)
