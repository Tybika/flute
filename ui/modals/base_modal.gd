extends PopupPanel
class_name BaseModal

@export var back_button: Node
@export var modal_data: ProblemData
@export var handler: Dictionary

# Implement this block on subclasses
func _ready() -> void:
	pass

func set_data(data: ProblemData):
	modal_data = data

func set_handler(handler_ref: Dictionary):
	print(handler_ref["node"])
	handler["node"] = handler_ref["node"]
	handler["method"] = handler_ref["method"]
	print("conectou handler:", handler)

func setup():
	if back_button:
		back_button.button_up.connect(_on_back_button)
	
	exclusive = true
	await get_tree().process_frame
	# REMOVER, PAENAS PARA DEBUG
	#popup()

func _on_back_button() -> void:
	hide()
