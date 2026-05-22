extends PopupPanel
class_name BaseModal

@export var back_button: Node
@export var modal_data: ProblemData
@export var handler: Dictionary

var _debug_error_alert: CanvasLayer

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

func _on_debug_button_up() -> void:
	if has_method("check_answer") and call("check_answer"):
		return

	_show_debug_error_alert()

func _show_debug_error_alert() -> void:
	if is_instance_valid(_debug_error_alert):
		_debug_error_alert.queue_free()

	var layer := CanvasLayer.new()
	layer.name = "DebugErrorAlert"
	layer.layer = 100
	_debug_error_alert = layer

	var overlay := Control.new()
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(overlay)

	var panel := PanelContainer.new()
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	panel.offset_left = 240
	panel.offset_top = 22
	panel.offset_right = -240
	panel.offset_bottom = 72
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0.9)
	style.set_corner_radius_all(4)
	panel.add_theme_stylebox_override("panel", style)
	overlay.add_child(panel)

	var label := Label.new()
	label.text = "erro log: -- "
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.add_theme_color_override("font_color", Color(1.0, 0.1, 0.1))
	label.add_theme_font_size_override("font_size", 24)
	panel.add_child(label)

	get_tree().root.add_child(layer)
	await get_tree().create_timer(2.0).timeout

	if is_instance_valid(layer):
		layer.queue_free()
