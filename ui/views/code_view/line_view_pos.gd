extends ScrollContainer

@onready var vbox: VBoxContainer = $VBox

@export var code_data: Array[String]

var edit_counter: int = 0
# Guarda quais índices são fixos (não podem ser movidos)
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

	for i in range(code_data.size()):
		var linecode = code_data[i]
		var instance: Control = draggable_scene.instantiate()
		instance.name = "DraggableLine" + str(edit_counter)
		edit_counter += 1

		# Prefixo "1" = linha arrastável; sem prefixo = linha fixa
		if linecode.begins_with("1"):
			instance.config_line(linecode.substr(1), true)
		else:
			instance.config_line(linecode, false)
			fixed_indices.append(i)

		instance.size_flags_horizontal = SIZE_EXPAND_FILL
		instance.size_flags_vertical = SIZE_EXPAND_FILL
		vbox.add_child(instance)

# Chamado pelo DraggableLine ao receber drop
func reorder_line(dragged: Control, target: Control, _at_pos: Vector2) -> void:
	if dragged == target:
		return

	var dragged_index = dragged.get_index()
	var target_index = target.get_index()

	# Impede mover para uma posição fixa
	if target_index in fixed_indices:
		return

	# Impede mover uma linha fixa
	if dragged_index in fixed_indices:
		return

	vbox.move_child(dragged, target_index)

# Retorna os filhos na ordem atual (para check_answer)
func get_ordered_children() -> Array[Node]:
	return vbox.get_children()
