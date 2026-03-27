extends ScrollContainer

@onready var vbox = $VBox
@export var code_data: Array[String]
static var edit_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if code_data:
		create_lines()

func create_lines():
	var instance: Node
	
	for linecode in code_data:
		if linecode.is_empty():
			instance = HBoxContainer.new()
			instance.name = "EditableLine" + str(edit_counter)
			edit_counter += 1
		else:
			instance = Label.new()
			instance.text = linecode
		
		vbox.add_child(instance)
