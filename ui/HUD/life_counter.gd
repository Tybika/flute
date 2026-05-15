extends HBoxContainer

@onready var life = preload("res://ui/HUD/life.tscn")
var lifes_status : Array[bool]
var current_theme: String

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
	update_total_life()
	
# Lose one life
func lose_life() -> void:
	_update_current_life(false)

# Regens one lost life
func regen_life() -> void:
	_update_current_life()

func _update_current_life(life_status: bool = true):
	var length = len(lifes_status)
	
	var iter = {
		false: [length - 1, 0, -1],
		true: [0, length, 1]
	}
	
	for i in range(iter[life_status][0], iter[life_status][1], iter[life_status][2]):
		if not lifes_status[i] == life_status:
			lifes_status[i] = life_status
			var this_life = get_child(i)
			update_style(this_life, lifes_status[i])
			break

func update_total_life(new_total : int = default_min):
	if new_total > default_max:
		new_total = default_max
	elif new_total < default_min:
		new_total = default_min
	
	var current = len(lifes_status)
	
	if new_total > current:
		for i in range(current, new_total):
			lifes_status.push_front(true)
			var new_life = life.instantiate()
			add_child(new_life)
			move_child(new_life, 0)
			update_style(new_life)
	
	elif new_total < current:
		var remaining_children = get_children().slice(new_total)
		
		for child in remaining_children:
			lifes_status.pop_back()
			remove_child(child)

func update_style(life_node: Node = null, status: bool = true):
	var res_dict = null
	
	if current_theme == "8":
		res_dict = res_8
	elif current_theme == "32":
		res_dict = res_32
	
	if not res_dict == null:
		if life_node == null:
			var lifes = get_children()
			
			for i in range(len(lifes)):
				lifes[i].texture = res_dict[status_to_res[lifes_status[i]]]
			
		else:
			life_node.texture = res_dict[status_to_res[status]]

func style_32bit():
	current_theme = "32"
	update_style()

func style_8bit():
	current_theme = "8"
	update_style()
