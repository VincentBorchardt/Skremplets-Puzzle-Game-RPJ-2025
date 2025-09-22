class_name CharacterTextureButton extends TextureButton

signal pressed_with_character(given_character)

@export var character: Character

func _on_pressed() -> void:
	pressed_with_character.emit(character)
