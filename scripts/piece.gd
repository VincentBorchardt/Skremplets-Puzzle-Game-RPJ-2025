class_name Piece extends Resource

@export var owner: Inventory.Player
@export var root_point_location: Vector2i
@export var secondary_points: Array[Vector2i]
@export var image: Texture2D
@export var type: Inventory.Type
@export var translation: Vector2
# currently in radians (so 90 degrees = TAU/4), 
@export var rotation: float

func is_special_touching(piece2):
	if piece2.type == Inventory.Type.GARBAGE or piece2.type == Inventory.Type.POWERUP:
		for point1 in self.secondary_points:
			for point2 in piece2.secondary_points:
				var x_dist = abs(point1.x - point2.x)
				var y_dist = abs(point1.y - point2.y)
				if x_dist <= 1 and y_dist <= 1 and not (x_dist == 1 and y_dist == 1):
					return true
	return false

func is_touching(piece2):
	if self == piece2 or ((self.type != piece2.type) and piece2.type != Inventory.Type.WILD):
		return false
	else:
		for point1 in self.secondary_points:
			for point2 in piece2.secondary_points:
				var x_dist = abs(point1.x - point2.x)
				var y_dist = abs(point1.y - point2.y)
				if x_dist <= 1 and y_dist <= 1 and not (x_dist == 1 and y_dist == 1):
					return true
	return false

func rotate(new_rotation_angle):
		rotation = rotation + new_rotation_angle
		translation = Vector2i(Vector2(translation).rotated(new_rotation_angle).round())
		for i in range(secondary_points.size()):
			var point = secondary_points[i]
			secondary_points[i] = Vector2i(Vector2(point).rotated(new_rotation_angle).round())

# This function is going to be hard--right now I'm not going to check for off-the-grid
# and that will cause false positives, but they can be caught elsewhere
func get_adjacent_points():
	var adjacent_points = []
	for starting_point in self.secondary_points:
		var possible_points = [starting_point + Vector2i(1, 0), starting_point - Vector2i(1, 0), 
		starting_point + Vector2i(0, 1), starting_point - Vector2i(0, 1)]
		for candidate in possible_points:
			if not (adjacent_points.has(candidate) or self.secondary_points.has(candidate)):
				adjacent_points.append(candidate)
	return adjacent_points

# TODO This isn't called anywhere, and I think it's broken
#func points_on_grid(grid_x, grid_y):
	#for point in self.secondary_points:
		#if (point.x < 0 or point.y < 0 or point.x >= grid_x or point.y >= grid_y):
			#return false
		#else:
			#return true

func pick_up_piece(player):
	self.owner = player
	for i in range(secondary_points.size()):
		secondary_points[i] = secondary_points[i] - root_point_location
	root_point_location = Vector2i(0, 0)
	rotate(-(rotation))

func should_not_be_matched():
	return (type == Inventory.Type.WILD or type == Inventory.Type.GARBAGE or type == Inventory.Type.POWERUP)

func _to_string() -> String:
	return "Piece at " + str(root_point_location) + ", " + str(secondary_points)
