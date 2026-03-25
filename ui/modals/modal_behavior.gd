extends PopupPanel

@export var back_button: Node
@export var modal_data: Resource

signal closed_modal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if back_button:
		back_button.button_up.connect(_on_back_button)
	
	exclusive = true
	await get_tree().process_frame
	popup()

func _on_back_button() -> void:
	hide()

func _on_popup_hide() -> void:
	closed_modal.emit()
