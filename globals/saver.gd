extends Node

var basic_save : Dictionary= {
	"scene": "",
	"theme": "",
	"style": "",
	"shader": false,
	"problems_status": {},
	"solved_problems": [],
	"achievements": [],
}

var last_save: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_save = saveload()


func handle_problems(data):
	pass

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
	
	return {}

func _map_data(data: Dictionary) -> Dictionary:
	return {}

func save():
	var data = _get_data()
	
	for key in basic_save:
		if data.has(key):
			basic_save[key] = data[key]
	
	if data.has("problems"):
		basic_save["solved_problems"] = handle_problems(data["problems"])
	
	_merge_saves()
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(basic_save)
	save_file.store_line(json_string)
	
	_reset_save()

func saveload() -> Dictionary:
	return {}

func get_last_save() -> Dictionary:
	return {}
