extends CharacterBody2D

@onready var body = $BodySprite
@onready var dialogue = $DialogueSprite

@export var anim_handler: Node

var theme_suffix: String = "8"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	set_physics_process(false)

func activate_physics():
	set_physics_process(true)

func spin(repeat: int = 1):
	for i in range(repeat):
		body.play("spin_" + theme_suffix)
	await body.animation_finished

func tools_cutscene_out():
	var tween = self.create_tween()
	
	tween.tween_property(self, "position", Vector2(position.x, -100), 2.4)
	body.play("back_walking_" + theme_suffix)

func tools_cutscene_back():
	var tween = self.create_tween()
	tween.tween_property(self, "position", Vector2(position.x, 325), 
			2.4).finished.connect(func(): body.play("front_idle_" + theme_suffix))
	body.play("front_walking_" + theme_suffix)

func drop_cutscene_mov():
	pass

func castle_cutscene_mov():
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
