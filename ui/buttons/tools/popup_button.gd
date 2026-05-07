extends Control

@export var linked_modal: PopupPanel
@onready var button = $Button

var res : Dictionary[String, Resource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_res()

func get_res():
	var node_name = self.get_name().to_lower()
	if node_name.contains("doc"):
		res = {
			"8": preload("res://ui/buttons/tools/docs_8.png"),
			"32": preload("res://ui/buttons/tools/docs_32.png"),
		}
	elif node_name.contains("project"):
		res = {
			"8": preload("res://ui/buttons/tools/project_8.png"),
			"32": preload("res://ui/buttons/tools/project_32.png"),
		}

func style_8bit():
	button.set_button_icon(res["8"])

func style_32bit():
	button.set_button_icon(res["32"])

func _on_button_button_up() -> void:
	if linked_modal:
		linked_modal.show()
