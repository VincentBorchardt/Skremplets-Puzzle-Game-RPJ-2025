extends Node

# TODO putting this here since it should be a singleton somewhere, and it'll help with debugging
# Probably should get renamed at some point

var next_level_info: LevelInfoContainer
var player_character = preload("res://resources/characters/grymmt_dundle.tres")
var opponent_character = preload("res://resources/characters/orchk.tres")
var all_opponents = [preload("res://resources/characters/grymmt_dundle.tres"),
preload("res://resources/characters/orchk.tres"), preload("res://resources/characters/pastoriche.tres")]
var possible_opponents = all_opponents.duplicate()

var current_level_number = 0:
	set(new_number):
		current_level_number = new_number
		if new_number < level_intros.size():
			current_level_intro = level_intros[new_number]

var level_intros = ["It’s time for the 43rd annual Equipment Haven Collective Trash Battle tournament! 
We have a hungry group of Skremplets facing off today, and let’s meet our first competitors!",
"We’re ready for the second round of the Equipment Haven Collective Trash Battle tournament! 
Let’s meet our next competitors!"]

var current_level_intro
var tournament_rounds = 2

var boyhowdy_unlocked = false
var dsd_unlocked = false

# TODO move Type and PowerUpType to PiecesContainer; they make sense there
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum AIPickingPattern {RANDOM, MOST, BIGGEST}
enum AIPlacementPattern {RANDOM_MATCHING, ANTI_GARBAGE}

func _ready() -> void:
	current_level_intro = level_intros[current_level_number]

func reset_opponents():
	current_level_number = 0
	possible_opponents = all_opponents.duplicate()

func set_up_story_level():
	# Advance the level counter in the end-of-level before calling this
	possible_opponents.erase(player_character)
	var pieces = Pieces.level_pieces_array[current_level_number]
	if current_level_number < tournament_rounds:
		var opp_index = randi() % possible_opponents.size()
		opponent_character = possible_opponents[opp_index]
		possible_opponents.erase(opponent_character)
		next_level_info = LevelInfoContainer.create_new_level_info(
			player_character, opponent_character, pieces, true, []
		)
	else:
		# TODO Set up the match with Boyhowdy
		opponent_character = preload("res://resources/characters/boyhowdy.tres")
		player_character.depowered = true
		next_level_info = LevelInfoContainer.create_new_level_info(
			player_character, opponent_character, pieces, true, [Pieces.sweater_power_up.duplicate()]
		)
	

func start_new_story_level():
	# TODO add a parameter that checks if it's a restart, so this can be universal
	# TODO this should be a match, either here or in set_up_story_level
	current_level_number = current_level_number + 1
	if current_level_number > tournament_rounds:
		if player_character.has_sweater:
			get_tree().change_scene_to_file("res://scenes/cutscenes/round_3_end_cutscene.tscn")
			return
		else:
			# TODO The secret ending where you face DSD, assuming I get it done
			# Set up a level with DSD,
			player_character.depowered = false
			opponent_character = preload("res://resources/characters/dark_shippie_dues.tres")
			var pieces = Pieces.level_pieces_array[current_level_number]
			next_level_info = LevelInfoContainer.create_new_level_info(
				player_character, opponent_character, pieces, true, []
			)
			get_tree().change_scene_to_file("res://scenes/cutscenes/round_4_start_cutscene.tscn")
			return
	set_up_story_level()
	# TODO This check is done twice and probably shouldn't be
	# Probably involves calling this in the character select and starting at -1 or something
	if current_level_number < tournament_rounds:
		get_tree().change_scene_to_file("res://scenes/cutscenes/generic_pregame.tscn")
	else:
		# TODO Start the final sequence
		get_tree().change_scene_to_file("res://scenes/cutscenes/round_3_start_cutscene.tscn")
