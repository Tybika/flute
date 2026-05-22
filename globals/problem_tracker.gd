extends Node

# Mapa de título → resolvido (true/false)
var _problems: Dictionary = {}

func _ready() -> void:
	# Escuta o sinal global de problema resolvido
	SignalBus.problem_solved.connect(_on_problem_solved)

# Registra os problemas da cena atual (chamado pelo ProblemGrid)
func register_problems(problem_list: Array[ProblemData]) -> void:
	_problems.clear()
	for problem in problem_list:
		_problems[problem.title] = false

# Chamado quando um problema é resolvido
func _on_problem_solved(problem_title: String) -> void:
	if _problems.has(problem_title):
		_problems[problem_title] = true
		_check_all_solved()

# Verifica se todos foram resolvidos
func _check_all_solved() -> void:
	for title in _problems:
		if _problems[title] == false:
			return
	# Todos resolvidos!
	SignalBus.all_problems_solved.emit()

func is_solved(problem_title: String) -> bool:
	return _problems.get(problem_title, false)

func get_status() -> Dictionary:
	return _problems.duplicate()
