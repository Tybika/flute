extends Node2D

@export var problems: Array[ProblemData]
@onready var problem_grid = $UI/Control/HBox/Modals/ProblemGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(problems)
	if problems:
		problem_grid.set_problems(problems)
		problem_grid.grid_create()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
