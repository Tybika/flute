extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var icon: TextureRect = $HBoxContainer/DragIcon

var is_draggable: bool = false

signal drag_started(line_node)

func _ready() -> void:
	# Garante que o ícone começa escondido
	icon.hide()

func config_line(text: String, draggable: bool = false) -> void:
	is_draggable = draggable
	await ready
	label.set_text(text)
	if draggable:
		icon.show()
	else:
		icon.hide()

# Retorna o texto da linha (usado para verificar a resposta)
func get_text_value() -> String:
	return label.text

func _get_drag_data(_at_position: Vector2):
	# Só inicia o drag se a linha for arrastável
	if not is_draggable:
		return null

	# Cria um preview visual durante o arrasto
	var preview = Label.new()
	preview.text = label.text
	preview.add_theme_color_override("font_color", Color.WHITE)
	set_drag_preview(preview)

	# Emite sinal para o pai saber que o drag começou
	drag_started.emit(self)

	# O dado do drag é o próprio nó — o VBox usa isso para reposicionar
	return self

func _can_drop_data(_at_position: Vector2, data) -> bool:
	# Aceita o drop somente se o dado for um DraggableLine
	return data is Control and data.has_method("get_text_value")

func _drop_data(at_position: Vector2, data) -> void:
	# Notifica o pai (LineViewPos) para reordenar
	# O pai escuta o sinal e faz o move_child
	var parent = get_parent()
	if parent and parent.has_method("reorder_line"):
		parent.reorder_line(data, self, at_position)
