class_name PiecesContainer extends Node

@onready var blue_four_t = load("res://resources/pieces/blue/blue_four_t.tres")
@onready var blue_three_three_bag = load("res://resources/pieces/blue/blue_three_three_bag.tres")
@onready var green_four_t = load("res://resources/pieces/green/green_four_t.tres")
@onready var green_three_three_bottle = load("res://resources/pieces/green/green_three_three_bottle.tres")
@onready var red_five_two_jug = load("res://resources/pieces/red/red_five_two_jug.tres")
@onready var red_four_line = load("res://resources/pieces/red/red_four_line.tres")
@onready var yellow_four_square = load("res://resources/pieces/yellow/yellow_four_square.tres")
@onready var yellow_two_three_can = load("res://resources/pieces/yellow/yellow_two_three_can.tres")
@onready var purple_wide_barrel = load("res://resources/pieces/purple/purple_wide_barrel.tres")
@onready var purple_skinny_barrel = load("res://resources/pieces/purple/purple_skinny_barrel.tres")

@onready var garbage_block = load("res://resources/pieces/garbage/garbage_block.tres")
@onready var apple_power_up = load("res://resources/pieces/powerup/apple_power_up.tres")
@onready var nightmare_power_up = load("res://resources/pieces/powerup/nightmare_power_up.tres")
@onready var sound_at_one_powerup = load("res://resources/pieces/powerup/sound_at_one_power_up.tres")
@onready var sound_at_two_powerup = load("res://resources/pieces/powerup/sound_at_two_power_up.tres")
@onready var sweater_power_up = load("res://resources/pieces/powerup/sweater_power_up.tres")

@onready var level_one_pieces = [blue_four_t.duplicate(), red_four_line.duplicate(), yellow_four_square.duplicate()]
@onready var level_two_pieces = [blue_four_t.duplicate(), blue_three_three_bag.duplicate(), green_four_t.duplicate(),
green_three_three_bottle.duplicate(), red_four_line.duplicate(), red_five_two_jug.duplicate(), 
yellow_four_square.duplicate(), yellow_two_three_can.duplicate()]
@onready var level_three_pieces = [blue_four_t.duplicate(), blue_three_three_bag.duplicate(), green_four_t.duplicate(),
green_three_three_bottle.duplicate(), red_four_line.duplicate(), red_five_two_jug.duplicate(), 
yellow_four_square.duplicate(), yellow_two_three_can.duplicate(),]
@onready var level_pieces_array = [level_one_pieces, level_two_pieces, level_three_pieces, level_three_pieces]

var confirmed_test_piece

enum Type {RED, BLUE, YELLOW, GREEN, PURPLE, GARBAGE, POWERUP, WILD, NONE}
enum PowerUpType {NONE, GRYMMT, ORCHK_TWO, ORCHK_ONE, PASTORICHE, SWEATER}
