extends Control

@onready var circuit: TextureRect = $Circuit
@onready var button: TextureButton = $ScrewButton
@onready var problem: PackedScene = load("res://ui/windows/problem_window/problem_window.tscn")

@export var callable: Callable

var linked_problem: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_screw_button_button_up() -> void:
	circuit.show()
	button.hide()
	if linked_problem:
		linked_problem.show()
		print('voltando a instancia aí irra')
	else:
		linked_problem = problem.instantiate()
		print('instancia nova problem')
		add_child(linked_problem)
		print('adicionada instancia na árvore', typeof(linked_problem))


func _on_problem_grid_focus_entered() -> void:
	circuit.hide()
	button.show()
