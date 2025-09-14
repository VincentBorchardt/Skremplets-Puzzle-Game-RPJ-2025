extends Node

signal send_special_message(message)

@export var starting_message : Message
@export var ending_message : Message
@export var messages : Array[Message]
@export var randomize_messages : bool = false


func get_new_message():
	print("getting new message")
	return messages.pop_front()

func get_first_message():
	return starting_message

func get_ending_message():
	return ending_message
