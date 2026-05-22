extends Node2D

@onready var coloured_bg = $ColouredBackground
@onready var kingdom_bg = $KingdomBackground
@onready var tilemap = $TileMapLayer
@onready var mc = $MainCharacter
@onready var problem = $ProblemScreen

@export var current_theme: String
@export var current_color: String
@export var required_problems: Array[ProblemData] = []

var solved_problems: Array[ProblemData] = []
var _solved_problem_titles: Dictionary = {}
var _next_scene_already_requested: bool = false

signal next_scene_requested

const colors = {
	"black": Color.BLACK,
	"gray": Color("#303030"),
	"red": Color.CRIMSON,
	"marsala": Color.BROWN,
	"blue": Color.MIDNIGHT_BLUE,
	"navy": Color.NAVY_BLUE,
	"pink": Color("#C74A78"),
	"magenta": Color.DARK_MAGENTA,
	"green": Color.DARK_OLIVE_GREEN,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SignalBus.problem_solved.is_connected(_on_problem_solved):
		SignalBus.problem_solved.connect(_on_problem_solved)

	mc.turn_direction("right")
	update_style(current_theme, current_color)
	_check_required_problems()

func get_player():
	return mc

func update_style(style: String, color = null):
	var method_name = null
	
	if style == "8":
		method_name = "style_8bit"
		kingdom_bg.hide()
		if not color == null and colors.get(color, false):
			coloured_bg.set_color(colors[color])
		else:
			coloured_bg.set_color(colors["black"])
		
	elif style == "32":
		method_name = "style_32bit"
		kingdom_bg.show()
	
	if not method_name == null:
		tilemap.call(method_name)
		mc.call(method_name)
		problem.call(method_name)

func coin_alignment(alignment: String):
	problem.coin_alignment(alignment)

func life_update():
	problem.life_update()

func _on_problem_solved(problem_title: String) -> void:
	if _solved_problem_titles.has(problem_title):
		return

	var solved_problem = _find_problem_by_title(problem_title)
	if solved_problem == null:
		return

	_solved_problem_titles[problem_title] = true
	solved_problems.append(solved_problem)
	_check_required_problems()

func _find_problem_by_title(problem_title: String) -> ProblemData:
	for problem_data in problem.problems:
		if problem_data and problem_data.title == problem_title:
			return problem_data

	return null

func _check_required_problems() -> void:
	if _next_scene_already_requested:
		return

	var has_required_problem = false
	for required_problem in required_problems:
		if required_problem == null:
			continue

		has_required_problem = true
		if not _solved_problem_titles.has(required_problem.title):
			return

	if not has_required_problem:
		return

	_next_scene_already_requested = true
	next_scene_requested.emit()
