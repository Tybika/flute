extends Node2D

@export var first_time: bool = true
@onready var mc = $Mc
@onready var dg_layer = $DialoguesLayer
@onready var cc_layer = $ChoicesLayer
@onready var tb_layer = $ToolsLayer
@onready var nav = $Navigation

@onready var scene_order = [
	mc.spin,
	dg_layer.next, 
	cc_layer.next,
	dg_layer.next,
	cc_layer.next,
	dg_layer.next,
	dg_layer.next,
	mc.tools_cutscene_out,
	_create_alone_timer,
	]

var current = 0
signal add_tree_requested(item_name: String)

func _create_alone_timer():
	get_tree().create_timer(8).timeout.connect(_on_alone_timeout)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func start_cutscene():
	nav.hide()
	
	while current < len(scene_order):
			await call_current()
			_update_current()
	nav.show()


func _update_current() -> void:
	current += 1


func _clear_cutscene() -> void:
	scene_order.clear()
	current = 0


func call_current() -> void:
	await scene_order[current].call()


func call_scene_event(scene_event: Callable):
	await scene_event.call()


func _on_navigation_add_tree_requested(item_name: String) -> void:
	add_tree_requested.emit(item_name)


func _on_visibility_changed() -> void:
	if visible:
		await get_tree().process_frame
	
		if first_time:
			start_cutscene()


func _on_alone_timeout():
	_clear_cutscene()
	scene_order.append_array([mc.tools_cutscene_back, dg_layer.next, 
			dg_layer.next, tb_layer.show])
	start_cutscene() 
