class_name NewPlayLevelButton extends SceneButton

@export var level_info: LevelInfoContainer
@export var level_num: int = 0

func _pressed() -> void:
	Inventory.next_level_info = level_info
	Inventory.current_level_number = level_num
	pressed_with_scene.emit(attached_scene)
