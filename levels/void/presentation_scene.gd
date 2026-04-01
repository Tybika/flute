extends Node2D

@export var first_time: bool = true
@onready var mc = $Mc
@onready var dg_layer = $DialoguesLayer
@onready var cc_layer = $ChoicesLayer

@onready var scene_order = [
	mc.spin,
	dg_layer.next, 
	cc_layer.next,
	dg_layer.next,
	cc_layer.next,
	dg_layer.next,
	dg_layer.next,
	mc.tools_cutscene_mov,
	]

var current = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	if first_time:
		while current < len(scene_order):
			await call_current()
			update_current()


func update_current() -> void:
	current += 1

func call_current() -> void:
	await scene_order[current].call()

func call_scene_event(scene_event: Callable):
	await scene_event.call()

func _on_mc_animation_finished():
	pass
