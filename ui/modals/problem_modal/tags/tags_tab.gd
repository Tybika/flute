extends TabContainer

@onready var tag_scn : PackedScene = load("res://ui/modals/problem_modal/tags/tag.tscn")
@onready var tags_data: Dictionary[String, Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tags_data:
		create_tabs()

func set_tag_data(data: Dictionary[String, Array]) -> void:
	tags_data = data

func update() -> void:
	for child in get_children():
		remove_child(child)
	
	create_tabs()

func create_tabs() -> void:
	for key in tags_data:
		var flow = FlowContainer.new()
		flow.name = key
		create_tags(flow)
		add_child(flow)

func create_tags(parent: Container) -> void:
	if tags_data:
		for tag in tags_data[parent.name]:
			var instance = tag_scn.instantiate()
			instance.data = tag
			parent.add_child(instance)
