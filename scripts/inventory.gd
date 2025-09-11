extends Node

# TODO putting this here since it should be a singleton somewhere, and it'll help with debugging
# Probably should get renamed at some point
enum Player {PLAYER_1, PLAYER_2, UNOWNED}
enum Type {RED, BLUE, YELLOW, GREEN, PURPLE, GARBAGE, POWERUP, WILD, NONE}
enum PowerUpType {NONE, GRYMMT, ORCHK_TWO, ORCHK_ONE}
enum AIPickingPattern {RANDOM, MOST, BIGGEST}
enum AIPlacementPattern {RANDOM_MATCHING, ANTI_GARBAGE}
