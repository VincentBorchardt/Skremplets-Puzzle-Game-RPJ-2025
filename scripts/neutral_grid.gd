class_name NeutralGrid extends Grid

signal get_neutral_piece(piece, player)
signal start_ai_pick(piece_list, player)

# TODO This is a temporary hack to make neutral grids work in a basic form
# This should probably be in a global, or maybe tied to the specific level if/when they get implemented
var piece_storage = ["res://resources/pieces/blue_four_t.tres", "res://resources/pieces/red_four_line.tres", "res://resources/pieces/yellow_four_square.tres"]

func _ready() -> void:
	super()
	if grid_owner == Inventory.Player.UNOWNED:
		print("Populating Neutral Grid")
		populate_neutral_grid()

func grab_neutral_piece(location, player) -> void:
	#print("in _on_grid_space_grab_neutral_piece")
	#print("grabbing piece at " + str(location))
	var piece = piece_list.get_piece_at_location(location)
	if piece:
		var root = piece.root_point_location
		var pieces_to_clear = [piece]
		piece_list.remove_pieces(pieces_to_clear)
		for node in spaces_list:
			node.remove_pieces(pieces_to_clear)
		piece.pick_up_piece(player)
		get_neutral_piece.emit(piece, player)
		# TODO hardcoding Human versus AI here
		if player == Inventory.Player.PLAYER_1:
			start_ai_pick.emit(piece_list, Inventory.Player.PLAYER_2)
		repopulate_neutral_grid(root)
		#TODO This breaks because there's two roots it's trying to keep track of at once
		#$RepopulateTimer.start_with_root(root)

# TODO THIS IS EXTREMELY HARDCODED FOR NOW
func populate_neutral_grid():
	for i in range(5):
		var index = randi() % 3
		var piece = load(piece_storage[index]).duplicate()
		var location = Vector2i(((2 * i) + 1), 1)
		# TODO This doesn't check if the space is legal, it shouldn't in this hack but likely will eventually
		place_piece(piece, location)
	#print(piece_list)

func repopulate_neutral_grid(location):
	var index = randi() % 3
	var piece = load(piece_storage[index]).duplicate()
	place_piece(piece, location)

func _on_repopulate_timer_timeout_with_root(new_root: Variant) -> void:
	repopulate_neutral_grid(new_root)
