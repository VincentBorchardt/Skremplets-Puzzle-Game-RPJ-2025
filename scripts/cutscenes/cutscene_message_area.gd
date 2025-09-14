extends Control

signal get_new_message()
signal show_previous_messages(messages)

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
	speaker_label.text = message.speaker.person_name
	cutscene_message.text = message.message

func _on_advance_text_button_pressed():
	get_new_message.emit()


func _on_previous_messages_button_pressed():
	show_previous_messages.emit(previous_messages)
