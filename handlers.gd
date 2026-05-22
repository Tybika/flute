extends Node

var mc : Node
signal next_scene_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func do_nothing():
	pass

func coin_hot_reload(data: Dictionary):
	if data.has("answer"):
		pass

func cloud_hot_reload(data:Dictionary):
	pass

func joystick_hot_reload():
	mc = get_parent().get_player()
	print("ÓIA AQUI O MC SE ACHOU NE:", mc)
	mc.activate_physics()

func life_hot_reload():
	SceneManager.get_current_scene().life_update()

func theme_hot_reload(data: Dictionary):
	var current_scn = SceneManager.get_current_scene()
	if data.has("answer"):
		var answer = data["answer"].split(".")
		
		if answer[1].begins_with("8"):
			current_scn.update_style("8", answer[1].substr(1, -1).to_lower())
		else:
			current_scn.update_style("32")

func bg_hot_reload(data: Dictionary):
	# implement alternatives when non linear scenes been supported
	#if data.has("answer"):
		#data = data["answer"].get_slice("/", -1).get_slice(".png", 0)
	
	next_scene_requested.emit()

func goal_hot_reload(data: Dictionary):
	if data.has("answer") and typeof(data["answer"]) == TYPE_ARRAY:
		pass
	SceneManager.get_current().update_mc_mov()
