extends Control

@onready var border = $MarginContainer/NinePatchRect
@onready var button = $MarginContainer/MarginContainer/Button
@export var button_text: String
@export var handler: Node
@export var handler_function: String

var normal = load("res://ui/buttons/generic/button_border.png")
var pressed = load("res://ui/buttons/generic/button_pressed.png")

signal button_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if button_text:
		set_button_text(button_text)
		
	if handler && handler_function:
		set_handler(handler, handler_function)

func set_button_text(btn_text: String) -> void:
	button.text = btn_text
	
func set_handler(handler_: Node, function_name: String) -> void:
	button.button_up.connect(Callable(handler_, function_name))
	
func _on_button_button_down() -> void:
	border.texture = pressed

func _on_button_up() -> void:
	border.texture = normal
	button_up.emit()
