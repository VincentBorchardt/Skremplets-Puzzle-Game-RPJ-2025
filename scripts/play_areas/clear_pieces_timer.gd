class_name ClearPiecesTimer extends Timer

signal timeout_with_piece_list(pieces)

var piece_list

func start_with_piece_list(pieces):
	piece_list = pieces
	start(0.5)


func _on_timeout() -> void:
	timeout_with_piece_list.emit(piece_list)
