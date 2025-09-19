extends Node

# TODO putting this here since it should be a singleton somewhere, and it'll help with debugging
# Probably should get renamed at some point

var next_level_info: LevelInfoContainer
var player_character = preload("res://resources/characters/grymmt_dundle.tres")

enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, GREEN, PURPLE, GARBAGE, POWERUP, WILD, NONE}
enum PowerUpType {NONE, GRYMMT, ORCHK_TWO, ORCHK_ONE, PASTORICHE}
enum AIPickingPattern {RANDOM, MOST, BIGGEST}
enum AIPlacementPattern {RANDOM_MATCHING, ANTI_GARBAGE}
