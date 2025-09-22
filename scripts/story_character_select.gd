extends Node2D

@onready var name_label = $TextBackground/CharacterSelectLabels/NameLabel
@onready var description_label = $TextBackground/CharacterSelectLabels/DescriptionLabel
@onready var power_up_label = $TextBackground/CharacterSelectLabels/PowerUpLabel
@onready var character_portrait = $CharacterPortrait


func _on_start_story_button_pressed_with_scene(scene: Variant) -> void:
	Inventory.set_up_story_level()
	get_tree().change_scene_to_packed(scene)

func _on_return_to_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_pressed_with_character(given_character: Variant) -> void:
	Inventory.player_character = given_character
	name_label.text = given_character.name
	description_label.text = given_character.select_description
	description_label.visible = true
	power_up_label.text = "PowerUp: " + given_character.power_up_description
	power_up_label.visible = true
	character_portrait.texture = given_character.full_picture_right
	character_portrait.visible = true
	$StartStoryButton.visible = true
