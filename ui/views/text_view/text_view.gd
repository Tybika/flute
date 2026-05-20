extends Control

@onready var label = $MarginContainer/Label

# Called when the node enters the scene tree for the first time.
func show_formatted(resource_path: String) -> void:
	var data = load(resource_path)
	label.text = data.long_text
	show()
