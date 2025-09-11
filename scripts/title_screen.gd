extends Node2D


func _on_scene_button_pressed_with_scene(scene: Variant) -> void:
	get_tree().change_scene_to_packed(scene)
