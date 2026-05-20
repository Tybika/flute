extends Node2D


@onready var problem_grid = $UI/Control/HBox/Modals/ProblemGrid
@onready var hud = $HUD/Hud
@onready var ui = $UI
@onready var tools = $UI/Control/HBox/ToolsColumn


@export var problems: Array[ProblemData]
@export var handlers: Array[Dictionary]
@export var default_theme : String = "32"
@export var hud_visible: bool = true
@export var problem_visible: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if problems:
		problem_grid.set_problems(problems)
		
		if handlers:
			_get_handler_from_path()
			problem_grid.set_handlers(handlers)
			
		problem_grid.grid_create()
		
	if default_theme and default_theme == "8":
		style_8bit()
	
	if not hud_visible:
		hide_hud()
	
	if not problem_visible:
		hide_problems()
	


func _update_style(method_name: String):
	hud.call(method_name)
	tools.call(method_name)


func _get_handler_from_path():
	for handler in handlers:
		handler["node"] = get_node(handler["node"])
	print("óia os handler que getou: ", handlers)

func coin_alignment(alignment: String):
	hud.coin_alignment(alignment)


func life_update():
	hud.life_default()


func show_hud():
	hud.show()


func show_problems():
	ui.show()


func hide_hud():
	hud.hide()


func hide_problems():
	ui.hide()


func style_8bit():
	_update_style("style_8bit")


func style_32bit():
	_update_style("style_32bit")
