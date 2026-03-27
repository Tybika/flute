extends Control

@onready var circuit: TextureRect = $Circuit
@onready var button: TextureButton = $ScrewButton
@export var linked_modal: PopupPanel;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if linked_modal:
		linked_modal.popup_hide.connect(_on_close_modal)

func _on_button_up() -> void:
	if linked_modal:
		linked_modal.show()
		circuit.show()
		button.hide()
	
func _on_close_modal():
	circuit.hide()
	button.show()
