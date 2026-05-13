extends Node

var materials = [
	load("res://shaders/glitch_material.tres"), 
	load("res://shaders/screen_glitch_material.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Chamar o save pra recuperar lá
	SignalBus.shader_requested.connect(activate)
	SignalBus.shader_released.connect(deactivate)

func _search_recursive(node: Node, target: Array, nodes: Array):
	if node is CanvasItem:
		if node.material in target:
			nodes.append(node)
	
	for child in node.get_children():
		_search_recursive(child, target, nodes)

func _get_shader_nodes() -> Array[Node]:
	var nodes: Array[Node] = []
	
	_search_recursive(SceneManager.get_current_scene(), materials, nodes)
	
	return nodes

func _set_active_state(state: bool):
	for node in _get_shader_nodes():
		node.material.set_shader_parameter("active", state)

func activate():
	_set_active_state(true)

func deactivate():
	_set_active_state(false)
