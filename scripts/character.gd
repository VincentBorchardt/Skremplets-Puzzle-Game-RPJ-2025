class_name Character extends Resource

@export var name: String
@export var depowered = false
@export var ai_picking_pattern: Inventory.AIPickingPattern
@export var ai_placement_pattern: Inventory.AIPlacementPattern
@export var main_image: Texture2D
#TODO handle powerups here somehow, either a powerup type or a function that gets called
