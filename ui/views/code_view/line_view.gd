extends ScrollContainer

@onready var vbox = $VBox
@onready var editable_line: PackedScene = load(
		"res://ui/modals/problem_modal/editable_line/editable_line.tscn")
@export var code_data: Array[String]
static var edit_counter = 0

var label_sett : LabelSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config_label_sett()
	if code_data:
		create_lines()

func config_label_sett():
	label_sett = LabelSettings.new()
	label_sett.set_font(preload("res://ui/views/code_view/CASCADIACODE.TTF"))

func create_lines():
	var instance: Control
	
	for linecode in code_data:
		if linecode.is_empty():
			instance = editable_line.instantiate()
			instance.name = "EditableLine" + str(edit_counter)
			edit_counter += 1
		else:
			instance = Label.new()
			instance.text = linecode
			instance.set_label_settings(label_sett)
			
		instance.size_flags_horizontal = SIZE_EXPAND_FILL
		instance.size_flags_vertical = SIZE_EXPAND_FILL
		vbox.add_child(instance)
		
		

func get_answer():
	var answer: Array[String] = []
	var children = vbox.get_children()
	
	for child in children:
		if child.has_method("get_value"):
			answer.append(child.get_value())
	
	return answer
