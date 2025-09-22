extends CanvasLayer

@onready var winner_label = $WinnerLabel
@onready var player_1_portrait = $Player1Portrait
@onready var player_1_label = $Player1Label
@onready var player_2_portrait = $Player2Portrait
@onready var player_2_label = $Player2Label

func set_up_winner_popup(level_info, loser):
	player_1_portrait.texture = level_info.player_1_character.full_picture_left
	player_2_portrait.texture = level_info.player_2_character.full_picture_right
	if loser == Inventory.Player.PLAYER_2: # Player 1 wins
		winner_label.text = str(level_info.player_1_character.name) + " Wins!"
		player_1_label.text = level_info.player_1_character.win_quote
		player_2_label.text = level_info.player_2_character.lose_quote
		$ContinueButton.visible = true
	else: # Player 2 wins
		winner_label.text = str(level_info.player_2_character.name) + " Wins!"
		player_1_label.text = level_info.player_1_character.lose_quote
		player_2_label.text = level_info.player_2_character.win_quote
		$ContinueButton.visible = false


func _on_continue_button_pressed() -> void:
	Inventory.start_new_story_level()

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscenes/generic_pregame.tscn")

func _on_title_screen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
