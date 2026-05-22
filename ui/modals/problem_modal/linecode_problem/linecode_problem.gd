extends BaseModal

@onready var tabs = $Content/VBox/TagsByType
@onready var modal_title = $Content/VBox/ToolBar/TitleLabel
@onready var line_view = $Content/VBox/LineView


signal shader_requested
signal shader_released

# Needs to call setup
func _ready() -> void:
	push_data()
	setup()

func _call_handler(data_param: Dictionary = {}):
	var node = handler["node"]
	var method_name = handler["method"]
	var methods = node.get_method_list()
	
	for method in methods:
		if method.name == method_name:
			var quantidade_args = method.args.size()
			
			if quantidade_args > 0:
				node.call(method_name, data_param)
				break
			
			else:
				node.call(method_name)
				break


func push_data():
	if modal_data:
		if modal_data.title:
			modal_title.text = modal_data.title
		
		if modal_data.tags:
			tabs.set_tag_data(modal_data.tags)
			tabs.update()
		
		if modal_data.context:
			line_view.set_code_data(modal_data.context)
			line_view.create_lines()

# Refatorar para permitir comportamento correto em mais de uma resposta: deve
# alterar a estrutura dos dados para diferenciar os campos e as respostas entre si
func check_answer() -> bool:
	if modal_data.answer_line && line_view.has_method("get_answer"):
		var user_answer = line_view.get_answer()
		
		for answer in modal_data.answer_line:
			if user_answer == answer.replace(" ", ""):
				return true
	
	return false

func check_syntax() -> bool:
	return false
	
func _on_hot_reload_button_up():
	if check_answer():
		shader_released.emit()
		SignalBus.problem_solved.emit(modal_data.title)
		
		if not handler == null:
			_call_handler(
				{
					"answer": line_view.get_answer(),
				}
			)
	else: 
		shader_requested.emit()
		
