extends Control

@onready var button = $Button
@export var linked_view: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_gui_input(event: InputEvent):
	if event is InputEventScreenTouch && event.double_tap:
		button.toggled()

func _on_button_toggled(toggled_on: bool) -> void:
	if linked_view:
		if toggled_on:
			linked_view.show()
		else:
			linked_view.hide()
