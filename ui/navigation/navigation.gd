extends Control

@export var top_scene_name: String
@export var bot_scene_name: String
@export var left_scene_name: String
@export var right_scene_name: String
@onready var player = $AudioStreamPlayer

signal add_tree_requested(item_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play_unvailable() -> void:
	player.play()

func go_to(target_name: String):
	add_tree_requested.emit(target_name)


func _on_ui_input_swipe(direction: String) -> void:
	match direction:
		"up":
			if top_scene_name:
				go_to(bot_scene_name)
			else: 
				play_unvailable()
		"down":
			if bot_scene_name:
				go_to(bot_scene_name)
			else: 
				play_unvailable()
		"left":
			if left_scene_name:
				go_to(left_scene_name)
			else: 
				play_unvailable()
		"right":
			if right_scene_name:
				go_to(right_scene_name)
			else: 
				play_unvailable()


func _on_visibility_changed() -> void:
	if visible:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED
