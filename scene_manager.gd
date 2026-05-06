extends Node2D

@onready var resources: Dictionary[String, PackedScene] = {
	"title": load("res://screens/title_screen/title_screen.tscn"),
	"void_cutscene": load("res://levels/void/presentation/presentation.tscn"),
	"void_level": load("res://levels/void/problem/problem.tscn"),
	"game": load("res://screens/problem_screen/problem_screen.tscn"),
}
@onready var game_save

@onready var title: Node
@onready var void_cutscene: Node
@onready var void_level: Node
@onready var game: Node
@onready var end: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title = _instance_of("title")
	void_cutscene = _instance_of("void_cutscene")
	void_level = _instance_of("void_level")
	game = _instance_of("game")
	
#	_connect_multiple_tree_signal(
#			[title, void_cutscene, void_room, game]
#			)
	_resize_control_node(title)
	_connect_multiple_tree_signal(
			[title, void_cutscene]
			)
	add_child(title)

func _resize_control_node(node: Control):
	node.size = Vector2(1280, 720)

func _remove_current_scene() -> void:
	remove_child(get_children()[0])

func _instance_of(resource_name: String) -> Node:
	return resources[resource_name].instantiate()

func _connect_multiple_tree_signal(nodes: Array[Node]):
	for node in nodes:
		_connect_tree_signal(node)

func _connect_tree_signal(node_emissor: Node) -> void:
	node_emissor.add_tree_requested.connect(_on_add_tree_requested)


func _switch_scene(new_scene: Node):
	add_child(new_scene)
	remove_child(get_child(0))

func _on_add_tree_requested(item_name: String) -> void:
	match item_name.to_lower():
		"void begin", "void begin", "void1", "presentation":
			_switch_scene(void_cutscene)
		"void background", "void level", "void2", "background":
			_switch_scene(void_level)
		_:
			print("NÃO MATCH")
