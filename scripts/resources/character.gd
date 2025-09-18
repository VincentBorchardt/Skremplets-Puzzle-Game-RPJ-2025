class_name Character extends Resource

@export var name: String
@export var depowered = false
@export var ai_picking_pattern: Inventory.AIPickingPattern
@export var ai_placement_pattern: Inventory.AIPlacementPattern
@export var player_1_portrait: Texture2D
@export var player_1_position: Vector2
@export var player_2_portrait: Texture2D
@export var player_2_position: Vector2

@export var full_picture_left: Texture2D
@export var full_picture_right: Texture2D
@export var character_select_portrait: Texture2D
#TODO handle powerups here somehow, either a powerup type or a function that gets called
