extends BaseModal

var view_data: Dictionary[String, Resource] = {
	"image_class": load("res://texts/image_class.tres"),
	"container_class": load("res://texts/container_class.tres"),
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()

func view_algo():
	pass

func _on_tree_item_selected() -> void:
	pass # Replace with function body.
