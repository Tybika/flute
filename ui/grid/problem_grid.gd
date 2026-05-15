extends Control

@export var problems: Array[ProblemData]
@export var handlers: Dictionary
@onready var grid_c = $GridContainer
@onready var modals = $Modals
@onready var grid_item = load("res://ui/grid/grid_item/grid_item.tscn")
@onready var problem_modal = load("res://ui/modals/problem_modal/linecode_problem/linecode_problem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_create()

func set_problems(problems_arr: Array[ProblemData]):
	problems = problems_arr

func set_handlers(handlers_arr: Dictionary):
	handlers = handlers_arr

func grid_create():
	if problems:
		var count = len(problems)
		if count < 3:
			grid_c.columns = count
			
		for i in range(len(problems)):
			var modal = problem_modal.instantiate()
			modal.set_data(problems[i])
			if i < len(handlers):
				print("conectou handler")
				modal.set_handler(handlers[i])
			modals.add_child(modal)
			
			var item = grid_item.instantiate()
			item.set_linked_modal(modal)
			
			grid_c.add_child(item)
