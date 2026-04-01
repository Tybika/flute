extends Control

@export var top: Node
@export var bot: Node
@export var left: Node
@export var right: Node

var initial_pos
var final_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func go_to():
	pass

func _on_ui_input_swipe(direction: String) -> void:
	match direction:
		"up":
			if top:
				print(top)
		"down":
			print("down")
		"left":
			print("left")
		"right":
			print("right")
