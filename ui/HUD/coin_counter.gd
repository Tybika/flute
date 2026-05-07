extends HBoxContainer

@onready var label = $CoinCounter
@onready var animator = $CoinIcon/AnimationPlayer

var counter = 0
var max_iter = 60
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	style_32bit()

func style_8bit():
	animator.play("coin_8")

func style_32bit():
	animator.play("coin_32")

func update_counter(new_value: int = 1000):
	var dif = abs(counter - new_value)
	
	if dif > max_iter:
		dif = max_iter
	
	for i in range(dif):
		var value = counter + i
		label.set_text(str(value))
		await get_tree().create_timer(0.03).timeout
	
	counter = new_value
	label.set_text(str(new_value))
