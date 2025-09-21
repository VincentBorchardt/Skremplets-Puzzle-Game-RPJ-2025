extends Node2D

# TODO find a way to combine this and the inevitable freeplay character select?




func _on_start_story_button_pressed_with_scene(scene: Variant) -> void:
	Inventory.set_up_story_level()
	get_tree().change_scene_to_packed(scene)

func _on_return_to_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
