class_name Character extends Resource

@export var name: String
@export var depowered = false
@export var ai_picking_pattern: Inventory.AIPickingPattern
@export var ai_placement_pattern: Inventory.AIPlacementPattern
@export var player_1_portrait: Texture2D
@export var player_1_position: Vector2
@export var player_2_portrait: Texture2D
@export var player_2_position: Vector2
#TODO handle powerups here somehow, either a powerup type or a function that gets called
