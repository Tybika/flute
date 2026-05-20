extends Node2D

@onready var camera = $Camera2D
@onready var problem = $ProblemScreen
@onready var mc = $MainCharacter

signal next_scene_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func on_bg_hot_reload(data: Dictionary):
	if data.has("answer"):
		var bg_name = data["answer"].get_slice("/", -1).get_slice(".png", 0)
		if bg_name.contains("final"):
			pass
	
	problem.queue_free()
	mc.drop_cutscene_mov()
	await get_tree().create_timer(3).timeout
	mc.turn_direction("right")
	camera.translate(Vector2(287, 0))
	await get_tree().create_timer(1.2).timeout
	next_scene_requested.emit()
