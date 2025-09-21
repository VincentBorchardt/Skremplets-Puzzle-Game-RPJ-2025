class_name CutsceneMessageArea extends Control

signal get_new_message()
signal show_previous_messages(messages)
#signal move_to_scene(scene)

@onready var speaker_label = $SpeakerLabel
@onready var cutscene_message = $CutsceneMessage
var current_message : Message
var previous_messages : Array[Message] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO move this up a level or two, this is logic
	# the signal itself is fine
	get_new_message.emit()

func display_new_message(message):
	if current_message != null:
		previous_messages.append(current_message)
	current_message = message
	speaker_label.text = message.speaker.name
	cutscene_message.text = message.message
	if message.choices:
		$AdvanceTextButton.visible = false
		$YesButton.visible = true
		$YesButton.attached_scene = message.yes_scene
		$NoButton.visible = true
		$NoButton.attached_scene = message.no_scene

func _on_advance_text_button_pressed():
	get_new_message.emit()


func _on_previous_messages_button_pressed():
	show_previous_messages.emit(previous_messages)

# TODO Does this work deep in a scene? Should it?
func _on_button_pressed_with_scene(scene: Variant) -> void:
	get_tree().change_scene_to_packed(scene)
