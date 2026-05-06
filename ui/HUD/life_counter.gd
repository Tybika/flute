extends HBoxContainer

@onready var life = preload("res://ui/HUD/life.tscn")
var lifes_status : Array[bool]

var res_8 : Dictionary[String, Resource] = {
	"filled" : preload("res://ui/HUD/heart_fill_8.png"),
	"outlined" : preload("res://ui/HUD/heart_outline_8.png"),
	"transition" : preload("res://ui/HUD/heart_center_8.png"),
}

var res_32 : Dictionary[String, Resource] = {
	"filled" : preload("res://ui/HUD/heart_fill_32.png"),
	"outlined" : preload("res://ui/HUD/heart_outline_32.png"),
	"transition" : preload("res://ui/HUD/heart_center_32.png"),
}

var status_to_res : Dictionary[bool, String] = {
	true : "filled",
	false : "outlined",
}

var default_min : int = 3
var default_max : int = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func lose_life() -> void:
	for i in range(len(lifes_status), 0, -1):
		if lifes_status[i]:
			lifes_status[i] = false
			var life = get_child(i)
			life.texture
			break
	
func regen_life() -> void:
	pass

func update_life_total(new_total : int = default_min):
	if new_total > default_max:
		new_total = default_max
	elif new_total < default_min:
		new_total = default_min
	
	var current = len(lifes_status)
	
	if new_total > current:
		for i in range(current, new_total):
			lifes_status.append(true)
			add_child(life.instantiate())
	
	elif new_total < current:
		var remaining_children = get_children().slice(new_total)
		
		for child in remaining_children:
			lifes_status.pop_back()
			remove_child(child)
	

func style_lifes(resource_dict: Dictionary):
	var lifes = get_children()
	
	for i in range(len(lifes)):
		lifes[i].texture = resource_dict[status_to_res[lifes_status[i]]] 

func style_32bit():
	style_lifes(res_32)

func style_8bit():
	style_lifes(res_8)
