extends Node

# Flute is a linear game
var scenes_order: Array[String] = [
	"title", 
	"void_cutscene", 
	"void_level",
	"kingdom_level",
	#"kingdom_play",
	#"kingdom_cutscene",
	"credits"
	]

var name_to_scene: Dictionary[String, PackedScene] = {
	"title": load("res://screens/title_screen/title_screen.tscn"),
	"void_cutscene": load("res://levels/void/presentation/presentation.tscn"),
	"void_level": load("res://levels/void/problem/problem.tscn"),
	"kingdom_level": load("res://levels/kingdom/kingdom_start.tscn"),
	"kingdom_play": load("res://levels/kingdom/ui_test.tscn"),
	"kingdom_cutscene": load("res://levels/kingdom/ui_test.tscn"),
	"credits": load("res://screens/credits/credits.tscn"),
}

var scenes: Array[Node]

# Para o save ser identificado independente da ordem de montagem
var current_name: String
var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Deve chamar um save antes pra modificar a ordem, caso necessário
	_init_scenes()
	_connect_g_signal()
	title()


func _init_scenes():
	
	
	for scene_name in scenes_order:
		var scn = name_to_scene[scene_name]
		scenes.append(scn.instantiate())
		
		if scn.has_method("set_current_theme"):
			scn.set_current_theme()

func _connect_g_signal():
	SignalBus.next_scene_requested.connect(_on_next_scene_requested)

func _resize_control_node(node: Control):
	node.size = Vector2(1280, 720)

func _remove_current_scene() -> void:
	remove_child(get_children()[0])

func _switch_scene(new_scene: Node):
	var tree = get_tree().root
	print(tree.get_children())
	tree.remove_child(tree.get_child(-1))
	print(tree.get_children())
	tree.add_child(new_scene)
	print(tree.get_children())

func _on_next_scene_requested():
	current_index += 1
	_switch_scene(scenes[current_index])

func title():
	_resize_control_node(scenes[0])
	var current = get_tree().current_scene
	
	if current.get_children().is_empty():
		current.add_child(scenes[0])
	else:
		_switch_scene(scenes[0])

func get_current_scene_name() -> String:
	return current_name

func get_current_scene() -> Node:
	return get_tree().current_scene
