extends Control

@export var problems: Array[ProblemData]
@onready var grid_c = $GridContainer
@onready var modals = $Modals
@onready var grid_item = load("res://ui/grid/grid_item/grid_item.tscn")
@onready var problem_modal = load("res://ui/modals/problem_modal/linecode_problem/linecode_problem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_create()

func set_problems(problems_arr: Array[ProblemData]):
	problems = problems_arr
	print("problemas setados: ", problems)

func grid_create():
	if problems:
		var count = len(problems)
		if count < 3:
			grid_c.columns = count
			
		for problem in problems:
			print("criando um item do grid")
			var modal = problem_modal.instantiate()
			modal.set_data(problem)
			modals.add_child(modal)
			
			var item = grid_item.instantiate()
			item.set_linked_modal(modal)
			grid_c.add_child(item)
			print("criou. Olhe os filhso: ", grid_c.get_children(), modals.get_children())
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
