extends NinePatchRect

@onready var container: MarginContainer = $"MarginContainer"
var last_size: Vector2 = size

func _on_margin_container_resized() -> void:
	if container:
		var new_x = container.size.x + 20
		var size_dif = new_x - last_size.x
		
		size.x += size_dif
		position.x -= size_dif
		last_size.x = new_x
