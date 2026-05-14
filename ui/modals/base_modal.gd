extends PopupPanel
class_name BaseModal

@export var back_button: Node
@export var modal_data: ProblemData
@export var handler: Dictionary

# Implement this block on subclasses and extends
func _ready() -> void:
	pass

func set_data(data: ProblemData):
	modal_data = data

func set_handler(node: Node, method_name: StringName, params: Dictionary):
	handler = {
		"node": node,
		"method": method_name,
		}
		
	if not params.is_empty():
		handler["params"] = params

func setup():
	if back_button:
		back_button.button_up.connect(_on_back_button)
	
	exclusive = true
	await get_tree().process_frame
	# REMOVER, PAENAS PARA DEBUG
	#popup()

func _on_back_button() -> void:
	hide()
