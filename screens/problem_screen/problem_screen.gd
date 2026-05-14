extends Node2D

@export var problems: Array[ProblemData]
@export var handler: Node
@export var methods: Array[StringName]
@onready var problem_grid = $UI/Control/HBox/Modals/ProblemGrid
@onready var hud = $HUD/Hud
@onready var ui = $UI
@onready var tools = $UI/Control/HBox/ToolsColumn
@export var default_theme : String = "32"
@export var hud_visible: bool = true
@export var problem_visible: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if problems:
		problem_grid.set_problems(problems)
		problem_grid.grid_create()
		
	if default_theme and default_theme == "8":
		style_8bit()
	
	if not hud_visible:
		hide_hud()
	
	if not problem_visible:
		hide_problems()
	

func update_style(method_name: String):
	hud.call(method_name)
	tools.call(method_name)

func show_hud():
	hud.show()

func show_problems():
	ui.show()

func hide_hud():
	hud.hide()

func hide_problems():
	ui.hide()

func style_8bit():
	update_style("style_8bit")

func style_32bit():
	update_style("style_32bit")
