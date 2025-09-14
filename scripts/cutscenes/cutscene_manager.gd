extends Node2D

@export var next_scene : PackedScene

@onready var message_queue = $MessageQueue
@onready var cutscene_ui = $CutsceneUI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cutscene_ui_get_new_message():
	if not message_queue:
		await self.ready
	var message = message_queue.get_new_message()
	if message != null:
		cutscene_ui.display_new_message(message)
	else:
		if next_scene != null:
			get_tree().change_scene_to_packed(next_scene)
		else:
			get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
