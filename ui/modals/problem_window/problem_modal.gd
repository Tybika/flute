extends BaseModal

@onready var tabs = $Content/VBox/TagsByType

# Needs to call setup
func _ready() -> void:
	if modal_data && modal_data.tags:
		tabs.set_tag_data(modal_data.tags)
		tabs.update()
	setup()
