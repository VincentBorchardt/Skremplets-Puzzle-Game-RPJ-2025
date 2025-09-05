class_name PreviewBox extends Control

# TODO Boxes are currently linked, need to say owner as well
# Won't come until Inventory is generalized, coming later

func _ready() -> void:
	Inventory.current_piece_changed.connect(_on_inventory_current_piece_changed)

func _on_inventory_current_piece_changed(new_piece):
	if new_piece == null:
		$PieceImage.visible = false
	else:
		$PieceImage.texture = new_piece.image
		$PieceImage.rotation = new_piece.rotation
		# TODO make this more general compared to how big the image is (and maybe the size of the box)
		$PieceImage.scale = Vector2(0.5, 0.5)
		$PieceImage.visible = true
