extends Control

@export var choice1 : String
@export var handler1 : Dictionary[Node, String]
@export var choice2 : String
@export var handler2: Dictionary[Node, String]

@onready var choice1_btn = $VBoxContainer/Choice1
@onready var choice2_btn = $VBoxContainer/Choice2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if choice1 && handler1:
		choice1_btn.set_button_text(choice1)
		choice1_btn.set_handler(handler1.keys()[0], handler1.values()[0])
	
	if choice2 && handler2:
		choice2_btn.set_button_text(choice2)
		choice2_btn.set_handler(handler2.keys()[0], handler2.values()[0])
	
func _on_button_up() -> void:
	queue_free()
