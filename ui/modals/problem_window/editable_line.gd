extends Control

@onready var tag_scn = load("res://ui/modals/problem_window/tags/tag.tscn")
@onready var hbox = $HBoxContainer
var current_tags: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data.has("scene")

func create_tag(data: Variant):
	var tag
	
	if data["from_editable"]:
		tag = data["ref"]
		
	else:
		tag = data["scene"].instantiate()
		tag.set_tag_text(data["text"])
		tag.from_editable = true
		hbox.add_child(tag)
		
	return tag

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var index = _get_drop_index(at_position)
	var tag = create_tag(data)
	
	if tag.get_parent() == hbox:
		move_child(tag, index)

func _get_drop_index(at_position: Vector2) -> int:
	var max_pos = hbox.get_child_count()
	for i in range(max_pos):
		var child = get_child(i)
		var pos = child.position.x + (child.size.x / 2)
		
		if at_position.x < pos:
			return i
	
	return max_pos
	

func create_clone_tag():
	pass

func set_answer():
	pass

func _on_tag_selected():
	pass
