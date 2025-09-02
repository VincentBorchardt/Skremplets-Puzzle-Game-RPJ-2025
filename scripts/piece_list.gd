class_name PieceList extends Resource

# TODO figure out if this should really be a dictionary or something else
# one of the points of this class is to hide that implementation detail
var list = {}

func add(piece, points):
	list[piece] = points
