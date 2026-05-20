extends BaseModal

@onready var view = $Content/VBoxContainer/HBoxContainer2/ScrollContainer2/TextView

var view_data: Dictionary[String, NodePath] = {
	"Image": "res://texts/image_class.tres",
	"Container": "res://texts/container_class.tres",
	"Row": "res://texts/row_class.tres",
	"Widget": "res://texts/widget_class.tres",
	"ColorScheme": "res://texts/colorscheme_class.tres",
	"ThemeData": "res://texts/themedata_class.tres",
	"MaterialApp": "res://texts/materialapp_class.tres",
	"Joystick": "res://texts/joystick_class.tres",
	"List": "res://texts/list_class.tres",
	"Operadores": "res://texts/operators.tres",
	"Classes": "res://texts/class.tres",
}

func _ready() -> void:
	setup()

func structure_links():
	pass

func _on_tree_item_selected(id):
	var item_name = id.get_text(0)
	if view_data.has(item_name):
		view.show_formatted(view_data[item_name])
