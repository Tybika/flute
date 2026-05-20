extends ScrollContainer

@onready var vbox = $VBox
@onready var draggable_line: PackedScene = load(
		"res://ui/modals/problem_modal/draggable_line/draggable_line.tscn")
@export var code_data: Array[String]

var edit_counter: int = 0
var label_sett : LabelSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if code_data:
		create_lines()



func set_code_data(data: Array[String]):
	code_data = data

func create_lines():
	var instance: Control
	
	
	for linecode in code_data:
		instance = draggable_line.instantiate()
		instance.name = "DraggableLine" + str(edit_counter)
		edit_counter += 1
		
		if linecode.begins_with("1"):
			instance.config_line(linecode.substr(1), true)
			
		else:
			instance.config_line(linecode)
			
		instance.size_flags_horizontal = SIZE_EXPAND_FILL
		instance.size_flags_vertical = SIZE_EXPAND_FILL
		vbox.add_child(instance)
		
	return
		

func get_answer() -> String:
	var answer: Array[String] = []
	var children = vbox.get_children()
	
	for child in children:
		if child.has_method("get_value"):
			answer.append(child.get_value())
	
	return "".join(answer).replace(" ", "")
