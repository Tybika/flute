extends Node2D

@export var problems: Array[ProblemData]
@onready var problem_grid = $UI/Control/HBox/Modals/ProblemGrid
@onready var hud = $HUD/Hud
@onready var tools = $UI/Control/HBox/ToolsColumn
@export var default_theme : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(problems)
	if problems:
		problem_grid.set_problems(problems)
		problem_grid.grid_create()
		
	if default_theme and default_theme == "8":
		style_8bit()

func update_style(method_name: String):
	hud.call(method_name)
	tools.call(method_name)

func style_8bit():
	update_style("style_8bit")

func style_32bit():
	update_style("style_32bit")
