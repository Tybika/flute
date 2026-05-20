extends Node

var basic_save : Dictionary= {
	"scene": "",
	"theme": "",
	"style": "",
	"shader": false,
	"problems": [],
	"solved_problems": [],
	"achievements": [],
}

var last_save: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_save = saveload()


func _reset_save():
	basic_save = {
		"scene": "",
		"theme": "",
		"style": "",
		"shader": false,
		"problems_status": {},
		"solved_problems": [],
		"achievements": [],
	}

func _merge_saves():
	for key in basic_save:
		if (basic_save[key] == null or basic_save[key].is_empty()) and last_save.has(key):
			basic_save[key] = last_save[key]

func _get_data() -> Dictionary:
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var problem = {
		"name": "",
		"answer": "",
	}
	
	
	for node in save_nodes:
		pass
	
	return {}

func _map_data(data: Dictionary) -> Dictionary:
	return {}

func saveload() -> Dictionary:
	return {}

func _on_save_requested():
	var data = _get_data()
	
	for key in basic_save:
		if data.has(key):
			basic_save[key] = data[key]
	
	if data.has("problems"):
		for problem in data["problems"]:
			_save_problem(problem)
	
	_merge_saves()
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(basic_save)
	save_file.store_line(json_string)
	
	_reset_save()

func _save_problem(problem: Dictionary):
	pass

func _on_load_requested() -> Dictionary:
	return {}

func get_last_save() -> Dictionary:
	return {}
