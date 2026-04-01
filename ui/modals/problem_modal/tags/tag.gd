extends PanelContainer

@onready var label: Label = $MarginContainer/Label
@export var data: String
var from_editable = false
var drag_origin: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data:
		label.text = data

func get_tag_text() -> String:
	return label.text

func set_tag_text(new_text: String):
	await ready
	label.text = new_text

func _drop_relative_pos(drop_position: Vector2):
	return position + drop_position

func _get_drag_data(at_position: Vector2) -> Variant:
	drag_origin = true
	
	var tag_data = {
		"scene": preload("res://ui/modals/problem_modal/tags/tag.tscn"),
		"text": label.text,
		"ref": self,
		"from_editable": from_editable,
	}
	
	var preview = duplicate()
	set_drag_preview(preview)
	
	return tag_data

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if !drag_origin:
			return
		
		drag_origin = false
		
		if get_viewport().gui_is_drag_successful():
			return
		
		if from_editable:
			queue_free()
