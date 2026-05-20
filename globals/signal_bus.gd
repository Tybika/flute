extends Node

signal save_requested
signal shader_requested
signal shader_released
signal add_tree_requested
signal next_scene_requested

const SIGNALS: Array = [
	"save_requested",
	"load_requested",
	"shader_requested",
	"shader_released",
	"add_tree_requested",
	"next_scene_requested",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_signals()
	get_tree().node_added.connect(_on_node_added)

func _create_signals():
	for signal_name in SIGNALS:
		Signal(self, signal_name)

func _connect_recursive(node: Node):
	for signal_info in node.get_signal_list():
		if signal_info.name in SIGNALS:
			Signal(node, signal_info.name).connect(emit_signal.bind(
					signal_info.name))
	
	for child in node.get_children():
		_connect_recursive(child)

func emit_any_signal(signal_name):
	emit_signal(signal_name)

func _on_node_added(node: Node):
	_connect_recursive(node)
