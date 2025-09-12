extends Timer

signal timeout_with_root(new_root)

var root

func start_with_root(new_root):
	var root = new_root
	start(0.5)
 
func _on_timeout() -> void:
	timeout_with_root.emit(root)
