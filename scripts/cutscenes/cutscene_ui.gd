extends Control

signal get_new_message()

@export var background_image : CompressedTexture2D

@onready var cutscene_message_area = $CutsceneMessageArea
@onready var left_image = $LeftImage
@onready var right_image = $RightImage

@onready var previous_messages_popup = $PreviousMessagesPopup
@onready var previous_messages_label = $PreviousMessagesPopup/PreviousMessagesLabel

func  _ready():
	if background_image != null:
		pass

func _on_cutscene_message_area_get_new_message():
	get_new_message.emit()

func display_new_message(message):
	var picture
	if message.alt_picture != null:
		picture = message.alt_picture
	else:
		picture = message.speaker.full_picture
	if message.image_location == Message.Location.LEFT:
		left_image.texture = picture
	elif message.image_location == Message.Location.RIGHT:
		right_image.texture = picture
	cutscene_message_area.display_new_message(message)

func _on_cutscene_message_area_show_previous_messages(messages):
	var message_string = "Previous Messages: \n \n"
	for entry in messages:
		message_string += entry.speaker.person_name + ": " + entry.message + "\n \n"
	previous_messages_label.text = message_string
	previous_messages_popup.visible = true

func _on_close_popup_button_pressed():
	previous_messages_popup.visible = false
