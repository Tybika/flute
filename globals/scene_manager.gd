extends Node

# Flute is a linear game
var scenes_order: Array[String] = [
	"title", 
	"void_cutscene", 
	"void_level",
	"kingdom_level",
	"kingdom_cutscene",
	"credits"
	]

var name_to_scene: Dictionary[String, PackedScene] = {
	"title": load("res://screens/title_screen/title_screen.tscn"),
	"void_cutscene": load("res://levels/void/presentation/presentation.tscn"),
	"void_level": load("res://levels/void/problem/problem.tscn"),
	"kingdom_level": load("res://screens/problem_screen/problem_screen.tscn"),
	"kingdom_cutscene": load("res://levels/kingdom/ui_test.tscn"),
	"credits": load("res://levels/kingdom/ui_test.tscn"),
}

var scenes: Array[Node]

var current_name: String
var current: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Deve chamar um save antes pra modificar a ordem, caso necessário
	_init_scenes()
	_connect_g_signal()

func _init_scenes():
	for scene_name in scenes_order:
		var scn = name_to_scene[scene_name]
		scenes.append(scn.instantiate())

func _connect_g_signal():
	SignalBus.next_scene_requested.connect(_on_next_scene_requested)

func _resize_control_node(node: Control):
	node.size = Vector2(1280, 720)

func _remove_current_scene() -> void:
	remove_child(get_children()[0])

func _switch_scene(new_scene: Node):
	add_child(new_scene)
	remove_child(get_child(0))

func _on_next_scene_requested():
	pass

func get_current_scene_name() -> String:
	return current_name

func get_current_scene() -> Node:
	return get_tree().current_scene
