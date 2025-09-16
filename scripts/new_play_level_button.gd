class_name NewPlayLevelButton extends SceneButton

@export var level_info: LevelInfoContainer


func _pressed() -> void:
	Inventory.next_level_info = level_info
	pressed_with_scene.emit(attached_scene)
