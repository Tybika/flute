extends CanvasLayer

signal dialogue_begun(dialogue_name: String)

func next():
	if get_child_count() > 0:
		var current_dialogue = get_child(0)
		dialogue_begun.emit(current_dialogue)
		current_dialogue.show()
		await current_dialogue.tree_exited

func _on_skip() -> void:
	get_child(0).queue_free()
