extends Timer

signal timeout_with_pieces(old_pieces)

var pieces

func start_with_pieces(old_pieces):
	var pieces = old_pieces
	start(0.5)
 
func _on_timeout() -> void:
	timeout_with_pieces.emit(pieces)
