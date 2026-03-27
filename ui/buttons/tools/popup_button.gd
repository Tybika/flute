extends Control

@export var linked_modal: PopupPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_button_button_up() -> void:
	if linked_modal:
		linked_modal.show()
