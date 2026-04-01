extends CenterContainer

@onready var img = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func show_img(resource_path = null) -> void:
	if resource_path is String:
		img.texture = load(resource_path)
		show()
	else:
		img.texture = null

func _on_project_item_selected():
	pass
