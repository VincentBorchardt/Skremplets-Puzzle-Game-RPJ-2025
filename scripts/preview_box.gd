class_name PreviewBox extends Control

func _ready() -> void:
	pass

func current_piece_changed(new_piece):
	if new_piece == null:
		$PieceImage.visible = false
	else:
		$PieceImage.texture = new_piece.image
		$PieceImage.rotation = new_piece.rotation
		# TODO make this more general compared to how big the image is (and maybe the size of the box)
		$PieceImage.scale = Vector2(0.5, 0.5)
		$PieceImage.visible = true
