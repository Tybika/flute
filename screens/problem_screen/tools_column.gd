extends MarginContainer

@onready var docs = $VBoxContainer/DocButton
@onready var wrench = $VBoxContainer/WrenchButton
@onready var project = $VBoxContainer/ProjectButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func update_style(method_name: String):
	docs.call(method_name)
	wrench.call(method_name)
	project.call(method_name)

func style_8bit():
	update_style("style_8bit")

func style_32bit():
	update_style("style_32bit")
