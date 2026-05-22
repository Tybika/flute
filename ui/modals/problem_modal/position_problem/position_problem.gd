extends BaseModal

@onready var num_column: VBoxContainer = $Content/VBox/HBoxContainer/EnumeratedColumn
@onready var modal_title: Label = $Content/VBox/ToolBar/TitleLabel
@onready var line_view = $Content/VBox/HBoxContainer/LineView

# Guarda a ordem correta (definida em modal_data.context, sem prefixos)
var correct_order: Array[String] = []

signal shader_requested
signal shader_released

func _ready() -> void:
	if modal_data:
		push_data()
		_build_correct_order()
		_gen_enum_column()
		shuffle_order()
		setup()

func _call_handler() -> void:
	var node = handler["node"]
	var method_name = handler["method"]

	if handler.has("params"):
		node.call(method_name, handler["params"])
	else:
		node.call(method_name)

func _gen_enum_column() -> void:
	if modal_data.context:
		for i in range(modal_data.context.size()):
			var num = Label.new()
			num.text = str(i + 1)
			num_column.add_child(num)

func push_data() -> void:
	if modal_data:
		if modal_data.title:
			modal_title.text = modal_data.title
		if modal_data.context:
			line_view.set_code_data(modal_data.context)
			line_view.create_lines()

# Monta o array com a ordem correta (contexto sem prefixo "1")
func _build_correct_order() -> void:
	correct_order.clear()
	for line in modal_data.context:
		if line.begins_with("1"):
			correct_order.append(line.substr(1))
		else:
			correct_order.append(line)

func shuffle_order() -> void:
	# Só embaralha as linhas arrastáveis
	var children = line_view.vbox.get_children()
	var movable: Array[Node] = []
	var fixed_positions: Dictionary = {}

	# Separa fixos dos móveis, guardando posição original dos fixos
	for i in range(children.size()):
		if i in line_view.fixed_indices:
			fixed_positions[i] = children[i]
		else:
			movable.append(children[i])

	# Embaralha apenas os móveis
	movable.shuffle()

	# Reposiciona: coloca os móveis nas posições não fixas
	var movable_cursor = 0
	for i in range(children.size()):
		if not fixed_positions.has(i):
			line_view.vbox.move_child(movable[movable_cursor], i)
			movable_cursor += 1

func check_answer() -> bool:
	var children = line_view.get_ordered_children()
	if children.size() != correct_order.size():
		return false

	for i in range(children.size()):
		var child_text = children[i].get_text_value()
		if child_text != correct_order[i]:
			return false

	return true

func _is_solved() -> bool:
	return check_answer()

func check_syntax() -> bool:
	return false

func _on_hot_reload_button_up() -> void:
	if check_answer():
		shader_released.emit()
		if not handler.is_empty():
			_call_handler()
	else:
		shader_requested.emit()
