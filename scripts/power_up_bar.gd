extends TextureProgressBar
# TODO This probably will become TextureProgressBar once final graphics come in
# TODO Should this be tied to a character? That would work to differentiate powerups?

signal activate_powerup

@export var bar_owner: Inventory.Player
@export var bar_size: int

func _ready() -> void:
	max_value = bar_size
	$PowerUpLabel.text = str(value) + "/" + str(max_value)

func add_to_bar(num_spaces):
	print("adding " + str(num_spaces) + " to powerup bar")
	if (max_value - value) >= num_spaces:
		value = value + num_spaces
		if value >= max_value:
			print("Go Powerup!")
			activate_powerup.emit()
			value = 0
	else:
		var intermediate_add = max_value - value
		value = value + intermediate_add
		print("Go Powerup!")
		activate_powerup.emit()
		value = 0
		add_to_bar(num_spaces - intermediate_add)
	$PowerUpLabel.text = str(value) + "/" + str(max_value)
