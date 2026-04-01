extends Node

const min_distance: float = 50

var initial_pos: Vector2
var final_pos: Vector2

var is_swiping: bool = false
signal ui_input_swipe(direction: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if !is_swiping && event.is_pressed():
			initial_pos = event.position
		else:
			is_swiping = false
			final_pos = event.position
			calc_drag()

func calc_drag():
	if initial_pos.distance_to(final_pos) > min_distance:
		var direction: Vector2 = initial_pos.direction_to(final_pos)
		var dir: String
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				dir = "left"
			else:
				dir = "right"
		else:
			if direction.y > 0:
				dir = "up"
			else:
				dir = "down" 
				
		ui_input_swipe.emit(dir)
