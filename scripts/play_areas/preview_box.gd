class_name PreviewBox extends Control

@export var box_image: Texture2D:
	set(image):
		$BoxImage.texture = image

func _ready() -> void:
	if box_image:
		$BoxImage.texture = box_image

func current_piece_changed(new_piece):
	if new_piece == null:
		$PieceImage.visible = false
	else:
		$PieceImage.texture = new_piece.image
		$PieceImage.rotation = new_piece.rotation
		# TODO make this more general compared to how big the image is (and maybe the size of the box)
		$PieceImage.scale = Vector2(0.5, 0.5)
		$PieceImage.visible = true
