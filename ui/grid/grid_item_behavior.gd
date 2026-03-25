extends Control

@onready var circuit: TextureRect = $Circuit
@onready var button: TextureButton = $ScrewButton
@onready var problem: PackedScene = load("res://ui/modals/problem_window/problem_window.tscn")

@export var linked_modal: Node = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Provavelmente esse processo deve ser realizado pelo objeto que cuida dos 
# modais na cena.
func instanciate_something():
	if linked_modal:
		linked_modal.show()
		print('voltando a instancia aí irra')
	else:
		linked_modal = problem.instantiate()
		print('instancia nova problem')
		add_child(linked_modal)
		print('adicionada instancia na árvore', typeof(linked_modal))

func _on_button_up() -> void:
	circuit.show()
	button.hide()
	
	instanciate_something()

func _on_release():
	circuit.hide()
	button.show()
