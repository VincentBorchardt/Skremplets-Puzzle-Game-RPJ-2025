class_name TextureSceneButton extends TextureButton

signal pressed_with_scene(scene)

@export var attached_scene : PackedScene

func _pressed():
	pressed_with_scene.emit(attached_scene)
