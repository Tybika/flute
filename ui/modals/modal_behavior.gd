extends PopupPanel

@export var modal_type: PackedScene
@export var modal_data: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	popup()
