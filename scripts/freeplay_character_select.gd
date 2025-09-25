extends Node2D

@onready var player_1_name_label = $Player1TextBackground/CharacterSelectLabels/NameLabel
@onready var player_1_description_label = $Player1TextBackground/CharacterSelectLabels/DescriptionLabel
@onready var player_1_power_up_label = $Player1TextBackground/CharacterSelectLabels/PowerUpLabel

@onready var player_2_name_label = $Player2TextBackground/CharacterSelectLabels/NameLabel
@onready var player_2_description_label = $Player2TextBackground/CharacterSelectLabels/DescriptionLabel
@onready var player_2_power_up_label = $Player2TextBackground/CharacterSelectLabels/PowerUpLabel

var player_1_character:
	set(char):
		player_1_character = char
		if player_1_character and player_2_character:
			$StartMatchButton.visible = true
var player_2_character:
	set(char):
		player_2_character = char
		if player_1_character and player_2_character:
			$StartMatchButton.visible = true

func _ready() -> void:
	if Inventory.boyhowdy_unlocked:
		$Player1CharacterButtons/BoyhowdyButton.visible = true
		$Player2CharacterButtons/BoyhowdyButton.visible = true
	if Inventory.dsd_unlocked:
		$Player1CharacterButtons/DSDButton.visible = true
		$Player2CharacterButtons/DSDButton.visible = true

func _on_start_match_button_pressed_with_scene(scene: Variant) -> void:
	# TODO let you pick your starting piece lineup--even a custom lineup possibly
	Inventory.next_level_info = LevelInfoContainer.create_new_level_info(
		player_1_character, player_2_character, Pieces.level_two_pieces, false, []
	)
	get_tree().change_scene_to_packed(scene)

func _on_return_to_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_player_1_pressed_with_character(given_character: Variant) -> void:
	player_1_character = given_character
	player_1_name_label.text = given_character.name
	player_1_description_label.text = given_character.select_description
	player_1_description_label.visible = true
	player_1_power_up_label.text = "PowerUp: " + given_character.power_up_description
	player_1_power_up_label.visible = true

func _on_player_2_pressed_with_character(given_character: Variant) -> void:
	player_2_character = given_character
	player_2_name_label.text = given_character.name
	player_2_description_label.text = given_character.select_description
	player_2_description_label.visible = true
	player_2_power_up_label.text = "PowerUp: " + given_character.power_up_description
	player_2_power_up_label.visible = true
