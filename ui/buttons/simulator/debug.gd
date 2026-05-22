extends Control

@onready var button: Button = $MarginContainer/Button
@export var handler: Node

func _ready() -> void:
	if handler:
		button.button_up.connect(handler._on_debug_button_up)
