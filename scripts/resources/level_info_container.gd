class_name LevelInfoContainer extends Resource

@export var piece_storage: Array[Piece]
@export var player_1_character: Character
@export var player_2_character: Character
@export var is_story: bool

static func create_new_level_info(player, opponent, pieces, story):
	var level_info = new()
	level_info.player_1_character = player
	level_info.player_2_character = opponent
	level_info.piece_storage = pieces
	level_info.is_story = story
	return level_info
