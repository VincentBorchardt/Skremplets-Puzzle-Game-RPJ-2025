extends ProgressBar
# TODO This probably will become TextureProgressBar once final graphics come in
# TODO Should this be tied to a character? That would work to differentiate powerups?

signal activate_powerup

@export var bar_owner: Player
@export var bar_size: int

enum Player {PLAYER_1, PLAYER_2, UNOWNED}

func _ready() -> void:
	max_value = bar_size

func convert_pieces(pieces, player):
	if player == bar_owner:
		var total_spaces = 0
		for piece in pieces:
			var piece_spaces = piece.secondary_points.size()
			total_spaces = total_spaces + piece_spaces
		add_to_bar(total_spaces)

func add_to_bar(num_spaces):
	print("adding " + str(num_spaces) + " to powerup bar")
	if (max_value - value) >= num_spaces:
		value = value + num_spaces
		if value >= max_value:
			print("Go Powerup!")
			activate_powerup.emit(bar_owner)
			value = 0
	else:
		var intermediate_add = max_value - value
		value = value + intermediate_add
		print("Go Powerup!")
		activate_powerup.emit(bar_owner)
		value = 0
		add_to_bar(num_spaces - intermediate_add)
