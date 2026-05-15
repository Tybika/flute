extends Node2D

signal next_scene_requested
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func on_bg_hot_reload(data: Dictionary):
	print("chamou_handler")
	if data.has("answer"):
		var bg_name = data["answer"].get_slice("/", -1).get_slice(".png", 0)
		if bg_name.contains("final"):
			next_scene_requested.emit()
