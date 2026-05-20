extends Control

@onready var label = $HBoxContainer/Label
@onready var icon = $HBoxContainer/DragIcon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _set_text(text: String):
	await ready
	label.set_text(text)

func _hide_icon(is_draggable: bool = false):
	await ready
	if is_draggable:
		icon.show()
	else:
		icon.hide()

func config_line(text: String, is_draggable: bool = false):
	_set_text(text)
	_hide_icon(is_draggable)
