extends Control

@onready var animator: AnimationPlayer = $TextureRect/AnimationPlayer
@onready var handSprite: TextureRect = $TextureRect
@onready var label: Label = $VBox/InstructionLabel
@onready var navigation = $Navigation

var timer = null

signal add_tree_requested(item_name: String)

const instructions = [
	"Ei… Clique uma vez em qualquer lugar para jogar",
	"Me enganei, clique duas vezes em qualquer lugar para jogar!",
	"",
	"Venha para a direita, é só arrastar…",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = instructions[0]

# Handles instruction changes on first single and double touch
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch && event.double_tap:
		label.text = instructions[2]
		swipe_require()
		self.gui_input.disconnect(_on_gui_input)
		
	elif event is InputEventScreenTouch:
		label.text = instructions[1]

# Changes swipe animation visibility and activate 5 seconds timer
func swipe_require():
	handSprite.show()
	animator.play("handling")
	timer = get_tree().create_timer(5)
	timer.timeout.connect(_on_timer_timeout)
	await get_tree().create_timer(1).timeout
	navigation.show()

# Provide instruction if player don't swipe in defined time
func _on_timer_timeout() -> void:
	label.text = instructions[3]


func _on_tree_exiting() -> void:
	timer.timeout.disconnect(_on_timer_timeout)
	print("tem alguma connection: ", timer.has_connections("timeout"))
