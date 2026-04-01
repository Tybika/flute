extends Control

@onready var tag_scn = load("res://ui/modals/problem_modal/tags/tag.tscn")
@onready var container = $HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func get_value() -> String:
	var tags = container.get_children()
	var tags_text: Array[String]
	
	for tag in tags:
		if tag.has_method('get_tag_text'):
			tags_text.append(tag.get_tag_text())
	
	return " ".join(tags_text)


func create_tag(data: Dictionary):
	var tag: Control
	
	if data["from_editable"]:
		tag = data["ref"]
		
	else:
		tag = data["scene"].instantiate()
		tag.set_tag_text(data["text"])
		tag.set_drag_forwarding(tag._get_drag_data, _can_drop_data, _drop_data)
		tag.from_editable = true
		container.add_child(tag)
		
	return tag


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY && data.has("scene")


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var index = _get_drop_index(at_position)
	var tag = create_tag(data)
	
	if tag.get_parent() == container:
		container.move_child(tag, index)


func _get_drop_index(at_position: Vector2) -> int:
	var max_pos = container.get_child_count()
	
	for i in range(max_pos):
		var child = container.get_child(i)
		var child_area = Rect2(child.position, child.size)
		
		if child_area.has_point(at_position):
			var relative_pos = at_position.x - child.position.x
			
			if relative_pos < (child.size.x/2):
				return i 
			else:
				return i+1
	
	return max_pos


func _on_tag_selected():
	pass


func _on_button_button_up() -> void:
	for child in container.get_children():
		child.queue_free()
