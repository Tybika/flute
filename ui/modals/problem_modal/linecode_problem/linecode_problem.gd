extends BaseModal

@onready var tabs = $Content/VBox/TagsByType
@onready var modal_title = $Content/VBox/ToolBar/TitleLabel
@onready var line_view = $Content/VBox/LineView

# Needs to call setup
func _ready() -> void:
	push_data()
	setup()

func push_data():
	if modal_data:
		print("DATA: ", modal_data)
		if modal_data.title:
			print(modal_title)
			modal_title.text = modal_data.title
		
		if modal_data.tags:
			tabs.set_tag_data(modal_data.tags)
			tabs.update()

# Refatorar para permitir comportamento correto em mais de uma resposta: deve
# alterar a estrutura dos dados para diferenciar os campos e as respostas entre si
func check_answer() -> bool:
	if modal_data.answer_line && line_view.has_method("get_answer"):
		var user_answer = line_view.get_answer()
		
		for u_answer in user_answer:
			for answer in modal_data.answer_line:
				if u_answer == answer:
					return true
	
	return false

func check_syntax() -> bool:
	return false
	
func _on_hot_reload_button_up():
	if check_answer():
		pass
	else: 
		pass
