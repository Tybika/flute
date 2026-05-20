extends BaseModal

@onready var num_column = $Content/VBox/HBoxContainer/EnumeratedColumn
@onready var modal_title = $Content/VBox/ToolBar/TitleLabel
@onready var line_view = $Content/VBox/HBoxContainer/LineView

var order_arr : Array[Node]

signal shader_requested
signal shader_released

# Needs to call setup
func _ready() -> void:
	if modal_data:
		push_data()
		_set_order_arr()
		enum_column_gen()
		setup()

func _call_handler():
	var node = handler["node"]
	var method_name = handler["method"]
	
	if handler.has("params"):
		node.call(method_name, handler["params"])
	else:
		node.call(method_name)

func enum_column_gen():
	if modal_data.context:
		for i in range(len(modal_data.context)):
			var num = Label.new()
			num.set_text(str(i+1))
			num_column.add_child(num)

func push_data():
	if modal_data:
		if modal_data.title:
			modal_title.text = modal_data.title
	
	if modal_data.context:
			line_view.set_code_data(modal_data.context)
			line_view.create_lines()

func shuffle_order():
	var children = line_view.get_children()
	
	randomize()
	children.shuffle()
	
	for i in range(children.size()):
		line_view.move_child(children[i], i)

func _set_order_arr():
	order_arr = line_view.get_children()
	order_arr.make_read_only()

# Refatorar para permitir comportamento correto em mais de uma resposta: deve
# alterar a estrutura dos dados para diferenciar os campos e as respostas entre si
func check_answer() -> bool:
	if line_view.get_children() == order_arr:
		return true
	
	return false

func check_syntax() -> bool:
	return false
	
func _on_hot_reload_button_up():
	if check_answer():
		shader_released.emit()
		
		if not handler == null:
			_call_handler()
	else: 
		shader_requested.emit()
		
