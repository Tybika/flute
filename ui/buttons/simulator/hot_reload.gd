extends Control

@onready var button: Button = $MarginContainer/Button
@export var handler: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("INICIALIZADO HEIN", handler)
	if handler:
		button.button_up.connect(handler._on_hot_reload_button_up)
		
