extends Control


# Variables to control write
var lines: Array[String] = []
var max_line_len: int = 150
var current_line: int = -1
var writing: bool = false
var writing_delay: float = 0

# Resource connection
@export var data: DialogueData

# Label node reference
@export var label_path: NodePath
@onready var label: Label = get_node(label_path)

# Get dialogues from resource, chuncks and starts it
func _ready() -> void:
	visible = false
	
	if data:
		lines = data.lines
		lines = chunck(lines)

# Divides lines bigger than max line length (default or max_length metadata) at last whitespace
func chunck(dialogue: Array[String]):
	if has_meta("max_length"):
		max_line_len = get_meta("max_length")
	
	var i = 0
	while i < dialogue.size():
		if dialogue[i].length() > max_line_len:
			var last_whitespace = dialogue[i].substr(0, max_line_len).rfind(" ")
			
			if last_whitespace == -1:
				last_whitespace = max_line_len
				
			var first_chunck = dialogue[i].substr(0, last_whitespace)
			var second_chunck = dialogue[i].substr(last_whitespace + 1)
			
			dialogue[i] = first_chunck
			if second_chunck.length() > 1:
				dialogue.insert(i + 1, second_chunck)
				
			else:
				i += 1
				
		else:
			i += 1

	return dialogue

# Updates writing delay based on line length
func calc_velocity(line_length: int):
	if line_length > 0:
		writing_delay = 0.7 / line_length

# Calls next dialogue if exists, excludes dialog box else
func next_dialogue():
	if lines && lines.size() > current_line + 1:
		current_line += 1;
		label.text = ""
		calc_velocity(lines[current_line].length())
		write_line(lines[current_line])
	else:
		queue_free()

# Write letters one by one, blocks interaction
func write_line(line: String):
	writing = true
	for letter in line:
		await get_tree().create_timer(writing_delay).timeout
		label.text = label.text + letter
	writing = false

# Handles touch at dialog box
func _on_dialogue_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch && !event.pressed && !writing:
		next_dialogue()


func _on_visibility_changed() -> void:
	if visible:
		next_dialogue()
