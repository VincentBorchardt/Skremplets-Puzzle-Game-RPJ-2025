extends Node

# TODO Determine whether this should be a global singleton or something else
# Global singleton works if we're going to differentiate player/AI, but I want MP to be a possibility
signal current_piece_changed

var current_piece = null:
	set(piece):
		current_piece = piece
		current_piece_changed.emit(piece)

func rotate_current_piece(rotation_angle):
	if current_piece:
		current_piece.rotate(rotation_angle)
		current_piece_changed.emit(current_piece)
