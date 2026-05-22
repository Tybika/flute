extends ScrollContainer

const LINE_HEIGHT := 24
const MIN_CONTENT_SIZE := Vector2(600, 200)
const TEXT_PADDING := Vector2(20, 20)

@onready var label: RichTextLabel = $MarginContainer/Label
@onready var margin_container: MarginContainer = $MarginContainer

func _ready() -> void:
	mouse_filter = MOUSE_FILTER_STOP
	margin_container.mouse_filter = MOUSE_FILTER_IGNORE
	label.mouse_filter = MOUSE_FILTER_IGNORE

func show_formatted(resource_path: String) -> void:
	var data = load(resource_path)
	label.text = data.long_text
	_update_content_size(data.long_text)
	show()

func _update_content_size(text: String) -> void:
	var font = label.get_theme_font("normal_font")
	var font_size = label.get_theme_font_size("normal_font_size")
	var longest_line_width = 0.0
	var line_count = 0

	for line in text.split("\n"):
		var line_width = font.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		longest_line_width = max(longest_line_width, line_width)
		line_count += 1

	line_count = max(line_count, 1)

	label.custom_minimum_size = Vector2(
		max(MIN_CONTENT_SIZE.x, longest_line_width + TEXT_PADDING.x),
		max(MIN_CONTENT_SIZE.y, line_count * LINE_HEIGHT + TEXT_PADDING.y)
	)
