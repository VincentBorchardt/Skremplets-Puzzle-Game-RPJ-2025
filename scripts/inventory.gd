extends Node

# TODO putting this here since it should be a singleton somewhere, and it'll help with debugging
# Probably should get renamed at some point

var next_level_info: LevelInfoContainer
var player_character = preload("res://resources/characters/grymmt_dundle.tres")
var opponent_character = preload("res://resources/characters/orchk.tres")
var possible_opponents = [preload("res://resources/characters/grymmt_dundle.tres"),
preload("res://resources/characters/orchk.tres"), preload("res://resources/characters/pastoriche.tres")]

var current_level_number = 0:
	set(new_number):
		current_level_number = new_number
		if new_number < level_intros.size():
			current_level_intro = level_intros[new_number]

var level_intros = ["It’s time for the 43rd annual Equipment Archive Collective Trash Battle tournament! 
We have a hungry group of Skremplets facing off today, and let’s meet our first competitors!",
"We’re ready for the second round of the Equipment Archive Collective Trash Battle tournament! 
Let’s meet our next competitors!"]

var current_level_intro

func _ready() -> void:
	current_level_intro = level_intros[current_level_number]

enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, GREEN, PURPLE, GARBAGE, POWERUP, WILD, NONE}
enum PowerUpType {NONE, GRYMMT, ORCHK_TWO, ORCHK_ONE, PASTORICHE}
enum AIPickingPattern {RANDOM, MOST, BIGGEST}
enum AIPlacementPattern {RANDOM_MATCHING, ANTI_GARBAGE}
