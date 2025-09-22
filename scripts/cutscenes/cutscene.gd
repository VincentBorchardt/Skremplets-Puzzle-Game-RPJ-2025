class_name Cutscene extends Node2D

@export var next_scene : PackedScene

@onready var message_queue = $MessageQueue
@onready var cutscene_ui = $CutsceneUI

var message
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cutscene_ui_get_new_message():
	if not message_queue:
		await self.ready
	message = message_queue.get_new_message()
	if message != null:
		if message.speaker.is_player:
			message.speaker = Inventory.player_character
		if message.speaker.is_opponent:
			message.speaker = Inventory.opponent_character
		message_replacements()
		cutscene_ui.display_new_message(message)
	else:
		if next_scene != null:
			get_tree().change_scene_to_packed(next_scene)
		else:
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func message_replacements():
	message.message = message.message.replace("$PLAYER_NAME", Inventory.player_character.name)
	message.message = message.message.replace("$PLAYER_DESCRIPTION", Inventory.player_character.pregame_description)
	message.message = message.message.replace("$PLAYER_OPENING", Inventory.player_character.opening_statement)
	message.message = message.message.replace("$OPPONENT_NAME", Inventory.opponent_character.name)
	message.message = message.message.replace("$OPPONENT_DESCRIPTION", Inventory.opponent_character.pregame_description)
	message.message = message.message.replace("$OPPONENT_OPENING", Inventory.opponent_character.opening_statement)
	message.message = message.message.replace("$INTRO", Inventory.current_level_intro)
