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
var tournament_rounds = 2

# TODO move Type and PowerUpType to PiecesContainer; they make sense there
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum AIPickingPattern {RANDOM, MOST, BIGGEST}
enum AIPlacementPattern {RANDOM_MATCHING, ANTI_GARBAGE}

func _ready() -> void:
	current_level_intro = level_intros[current_level_number]

func set_up_story_level():
	# Advance the level counter in the end-of-level before calling this
	if current_level_number < tournament_rounds:
		possible_opponents.erase(player_character)
		var opp_index = randi() % possible_opponents.size()
		opponent_character = possible_opponents[opp_index]
		possible_opponents.erase(opponent_character)
		var pieces = Pieces.level_pieces_array[current_level_number]
		next_level_info = LevelInfoContainer.create_new_level_info(
			player_character, opponent_character, pieces, true
		)
	else:
		# TODO Set up the match with Boyhowdy
		opponent_character = preload("res://resources/characters/boyhowdy.tres")
		# TODO Currently empty
		var pieces = Pieces.level_pieces_array[current_level_number]
		
	

func start_new_story_level():
	current_level_number = current_level_number + 1
	set_up_story_level()
	# TODO This check is done twice and probably shouldn't be
	# Probably involves calling this in the character select and starting at -1 or something
	if current_level_number < tournament_rounds:
		get_tree().change_scene_to_file("res://scenes/cutscenes/generic_pregame.tscn")
	else:
		# TODO Start the final sequence
		pass
