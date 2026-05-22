extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var icon: TextureRect = $HBoxContainer/DragIcon
@onready var row: HBoxContainer = $HBoxContainer

var is_draggable: bool = false


func _ready() -> void:
	mouse_filter = MOUSE_FILTER_STOP
	row.mouse_filter = MOUSE_FILTER_IGNORE
	label.mouse_filter = MOUSE_FILTER_IGNORE
	icon.mouse_filter = MOUSE_FILTER_IGNORE
	icon.hide()


func config_line(text: String, draggable: bool = false) -> void:
	is_draggable = draggable
	await ready
	label.set_text(text)
	if draggable:
		icon.show()
	else:
		icon.hide()


func get_text_value() -> String:
	return label.text


func _get_drag_data(_at_position: Vector2):
	if not is_draggable:
		return null

	var preview = duplicate()
	preview.modulate = Color(1, 1, 1, 0.85)
	set_drag_preview(preview)

	return self


func _can_drop_data(_at_position: Vector2, data) -> bool:
	return data is Control and data.has_method("get_text_value")


func _drop_data(at_position: Vector2, data) -> void:
	var line_view = _get_line_view()
	if line_view:
		line_view.reorder_line(data, self, at_position)


func _get_line_view() -> Node:
	var current = get_parent()
	while current:
		if current.has_method("reorder_line"):
			return current
		current = current.get_parent()
	return null
