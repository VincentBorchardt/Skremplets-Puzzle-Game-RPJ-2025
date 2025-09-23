extends Node2D

@onready var popup = $TitleScreenPopup

func _ready() -> void:
	Inventory.reset_opponents()

func _on_scene_button_pressed_with_scene(scene: Variant) -> void:
	get_tree().change_scene_to_packed(scene)

func _on_credits_button_pressed():
	popup.show_credits()


func _on_licenses_button_pressed():
	popup.show_licenses()


func _on_instructions_button_pressed():
	popup.show_instructions()
