extends CanvasLayer

@onready var programmer = $ProgramerChoice
@onready var help = $HelpChoice

signal skip_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func next():
	var current_choice = get_child(0)
	if current_choice :
		current_choice.show()
		await current_choice.tree_exited

func _on_exit_button_up():
	get_tree().quit()

func _on_programmer_button_up():
	pass

func _on_injustice_button_up():
	pass

func _on_accept_button_up():
	skip_scene.emit()
