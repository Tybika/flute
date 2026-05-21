extends Node2D

@onready var coloured_bg = $ColouredBackground
@onready var kingdom_bg = $KingdomBackground
@onready var tilemap = $TileMapLayer
@onready var mc = $MainCharacter
@onready var problem = $ProblemScreen

@export var current_theme: String
@export var current_color: String

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
	mc.turn_direction("right")
	update_style(current_theme, current_color)


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
