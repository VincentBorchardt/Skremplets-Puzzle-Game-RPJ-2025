extends CanvasLayer

@onready var winner_label = $WinnerLabel
@onready var player_1_portrait = $Player1Portrait
@onready var player_1_label = $Player1Label
@onready var player_2_portrait = $Player2Portrait
@onready var player_2_label = $Player2Label

var is_story = true

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
	if not is_story:
		$ContinueButton.visible = false
		$BackToFreeplayButton.visible = true


func _on_continue_button_pressed() -> void:
	if Inventory.current_level_number > Inventory.tournament_rounds:
		Inventory.dsd_unlocked = true
		get_tree().change_scene_to_file("res://scenes/cutscenes/round_4_end_cutscene.tscn")
	else:
		Inventory.start_new_story_level()

func _on_retry_button_pressed() -> void:
	# TODO does reloading the scene work, or do things break horribly?
	Inventory.player_character.has_sweater = false
	#Inventory.opponent_character.has_sweater = false
	if not is_story:
		get_tree().change_scene_to_file("res://scenes/cutscenes/round_3_start_cutscene.tscn")
		return
	if Inventory.current_level_number == Inventory.tournament_rounds:
		get_tree().change_scene_to_file("res://scenes/cutscenes/round_3_start_cutscene.tscn")
	elif Inventory.current_level_number > Inventory.tournament_rounds:
		get_tree().change_scene_to_file("res://scenes/cutscenes/round_4_start_cutscene.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/cutscenes/generic_pregame.tscn")

func _on_title_screen_button_pressed() -> void:
	# TODO I don't think these falses are necessary, but they won't hurt
	Inventory.player_character.has_sweater = false
	Inventory.opponent_character.has_sweater = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_back_to_freeplay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/freeplay_character_select.tscn")
