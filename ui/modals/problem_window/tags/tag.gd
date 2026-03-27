extends PanelContainer

@onready var label: Label = $MarginContainer/Label
@export var data: String
var init_pos: Vector2
var from_editable = false

#signal tag_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data:
		label.text = data
	init_pos = position

func set_tag_text(new_text: String):
	await ready
	label.text = new_text

func _get_drag_data(at_position: Vector2) -> Variant:
	var tag_data = {
		"scene": preload("res://ui/modals/problem_window/tags/tag.tscn"),
		"text": label.text,
		"ref": self,
		"from_editable": from_editable,
	}
	
	var preview = duplicate()
	preview.modulate.a = 0.6
	set_drag_preview(preview)
	
	return tag_data

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if get_viewport().gui_is_drag_successful():
			return
		
		if from_editable:
			queue_free()

#func _on_gui_input(event: InputEvent) -> void:
#	if event is InputEventScreenDrag and event.index == 0:
#		position += event.relative

#	elif event is InputEventScreenTouch && !event.is_pressed():
#		print(init_pos)
#		tag_selected.emit()
		
