extends ScrollContainer

@onready var label: RichTextLabel = $MarginContainer/Label

func show_formatted(resource_path: String) -> void:
	var data = load(resource_path)
	label.text = data.long_text
	show()
