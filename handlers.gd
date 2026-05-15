extends Node

signal next_scene_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_coin_hot_reload(data: Dictionary):
	if data.has("answer"):
		pass


func _on_life_hot_reload():
	SceneManager.get_current_scene().update_life()

func on_theme_hot_reload(data: Dictionary):
	var current_scn = SceneManager.get_current_scene()
	if data.has("answer"):
		data = data["answer"].split(".")
		
		if data[1].begins_with("8"):
			current_scn.update_style("8", data[1].substr(1, -1).to_lower())
		else:
			current_scn.update_style("32")

func on_bg_hot_reload(data: Dictionary):
	# implement alternatives when non linear scenes been supported
	#if data.has("answer"):
		#data = data["answer"].get_slice("/", -1).get_slice(".png", 0)
	
	next_scene_requested.emit()

func on_goal_hot_reload(data: Dictionary):
	if data.has("answer") and typeof(data["answer"]) == TYPE_ARRAY:
		pass
	SceneManager.get_current().update_mc_mov()
