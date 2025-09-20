class_name Character extends Resource

@export_group("")
@export var name: String
@export_multiline var description: String
@export_multiline var opening_statement: String
@export_multiline var win_quote: String
@export_multiline var lose_quote: String

@export_group("Attributes")
@export var is_player: bool = false
@export var is_opponent: bool = false
@export var depowered = false
@export var ai_picking_pattern: Inventory.AIPickingPattern
@export var ai_placement_pattern: Inventory.AIPlacementPattern
#TODO handle powerups here somehow, either a powerup type or a function that gets called

@export_group("images")
@export var player_1_portrait: Texture2D
@export var player_1_position: Vector2
@export var player_2_portrait: Texture2D
@export var player_2_position: Vector2
@export var full_picture_left: Texture2D
@export var full_picture_right: Texture2D
@export var character_select_portrait: Texture2D
