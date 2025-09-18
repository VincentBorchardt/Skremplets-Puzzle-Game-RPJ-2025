class_name Message extends Resource

@export var speaker : Character
@export_multiline var message : String
@export var alt_picture : Texture2D
@export var image_location : Location

@export var choices: bool
@export var yes_scene: PackedScene
@export var no_scene: PackedScene
enum Location {LEFT, RIGHT}
