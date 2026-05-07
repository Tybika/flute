extends Control

@onready var life_cont = $MarginContainer/VBoxContainer/InfoBar/LifeContainer
@onready var coin_cont = $MarginContainer/VBoxContainer/InfoBar/CoinContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func update_style(method_name: String):
	life_cont.call(method_name)
	coin_cont.call(method_name)

func style_8bit() -> void:
	update_style("style_8bit")
	
func style_32bit() -> void:
	update_style("style_32bit")

func coin_alignment(alignment: String):
	pass
