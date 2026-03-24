extends Control

@onready var circuit: TextureRect = $Circuit
@onready var button: TextureButton = $ScrewButton
@onready var p_window: PackedScene = load("res://ui/windows/problem_window/problem_window.tscn")

@export var callable: Callable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_screw_button_button_up() -> void:
	circuit.visible = true
	button.visible = false
	add_child(p_window.instantiate())
