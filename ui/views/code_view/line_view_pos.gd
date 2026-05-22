extends ScrollContainer

@onready var num_column: VBoxContainer = $HBox/NumColumn
@onready var vbox: VBoxContainer = $HBox/VBox

@export var code_data: Array[String]

var edit_counter: int = 0
var fixed_indices: Array[int] = []


func _ready() -> void:
	if code_data:
		create_lines()


func set_code_data(data: Array[String]) -> void:
	code_data = data


func create_lines() -> void:
	var draggable_scene: PackedScene = load(
		"res://ui/modals/problem_modal/draggable_line/draggable_line.tscn"
	)
	_clear_lines()
	fixed_indices.clear()

	for i in range(code_data.size()):
		_create_line_number(i + 1)

		var linecode = code_data[i]
		var instance: Control = draggable_scene.instantiate()
		instance.name = "DraggableLine" + str(edit_counter)
		edit_counter += 1

		if linecode.begins_with("1"):
			instance.config_line(linecode.substr(1), true)
		else:
			instance.config_line(linecode, false)
			fixed_indices.append(i)

		instance.size_flags_horizontal = SIZE_EXPAND_FILL
		instance.size_flags_vertical = SIZE_EXPAND_FILL
		vbox.add_child(instance)


func _clear_lines() -> void:
	for child in num_column.get_children():
		child.free()

	for child in vbox.get_children():
		child.free()


func _create_line_number(line_number: int) -> void:
	var label = Label.new()
	label.text = str(line_number)
	label.custom_minimum_size = Vector2(40, 40)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	num_column.add_child(label)


func reorder_line(dragged: Control, target: Control, at_pos: Vector2) -> void:
	if dragged == target:
		return

	var children = vbox.get_children()
	if not children.has(dragged) or not children.has(target):
		return

	if not _is_line_draggable(dragged):
		return

	var movable_nodes = _get_movable_nodes(children)
	var movable_slots = _get_movable_slots(children.size())
	if movable_nodes.size() != movable_slots.size():
		return

	var movable_without_dragged = movable_nodes.duplicate()
	movable_without_dragged.erase(dragged)

	var insert_index = _get_insert_index(target, at_pos, movable_without_dragged, movable_slots)
	if insert_index == -1:
		return

	movable_without_dragged.insert(clampi(insert_index, 0, movable_without_dragged.size()), dragged)
	_apply_movable_order(movable_without_dragged)


func _get_insert_index(
	target: Control,
	at_pos: Vector2,
	movable_without_dragged: Array,
	movable_slots: Array[int]
) -> int:
	var drop_after = at_pos.y >= target.size.y / 2.0
	var offset = 1 if drop_after else 0

	if _is_line_draggable(target):
		var target_index = movable_without_dragged.find(target)
		if target_index == -1:
			return -1
		return target_index + offset

	var desired_slot = target.get_index() + offset
	var nearest_slot = _get_nearest_movable_slot(desired_slot, drop_after, movable_slots)
	return movable_slots.find(nearest_slot)


func _get_nearest_movable_slot(desired_slot: int, prefer_after: bool, movable_slots: Array[int]) -> int:
	var fallback = -1

	for slot in movable_slots:
		if slot == desired_slot:
			return slot

		if prefer_after:
			if slot > desired_slot:
				return slot
			if slot < desired_slot:
				fallback = slot
		else:
			if slot < desired_slot:
				fallback = slot
			elif slot > desired_slot:
				return fallback if fallback != -1 else slot

	return fallback


func _apply_movable_order(ordered_movable: Array) -> void:
	var children = vbox.get_children()
	var final_order: Array[Node] = []
	var movable_cursor = 0

	for i in range(children.size()):
		if i in fixed_indices:
			final_order.append(children[i])
		else:
			final_order.append(ordered_movable[movable_cursor])
			movable_cursor += 1

	for i in range(final_order.size()):
		if final_order[i].get_index() != i:
			vbox.move_child(final_order[i], i)


func _get_movable_nodes(children: Array) -> Array:
	var movable: Array = []
	for child in children:
		if _is_line_draggable(child):
			movable.append(child)
	return movable


func _get_movable_slots(child_count: int) -> Array[int]:
	var slots: Array[int] = []
	for i in range(child_count):
		if not fixed_indices.has(i):
			slots.append(i)
	return slots


func _is_line_draggable(line: Node) -> bool:
	return line.has_method("get_text_value") and line.get("is_draggable") == true


func get_ordered_children() -> Array[Node]:
	return vbox.get_children()
