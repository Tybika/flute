extends Control

@onready var audio: Control = $MarginContainer/AudioView
@onready var image: Control = $MarginContainer/ImageView
@onready var text: Control = $MarginContainer/RawView

@export var view_data: Dictionary[String, String] = {
	"background.png" = "",
	"background_final.png" = "",
	"coin_icon.png" = "",
	"coin_icon2.png" = "",
	"life_icon.png" = "",
	"coin.wav" = "res://ui/modals/project_window/previews/Coin Flip.mp3",
	"coin2.wav" = "",
	"error.wav" = "",
	"step.wav" = "",
	"step_wet.wav" = "",
	"success.wav" = "",
	"player.dart" = "res://texts/player.tres",
	"joystick.dart" = "res://texts/joystick.tres",
	"life.dart" = "res://texts/lifecounter.tres",
	"main.dart" = "res://texts/main.tres",
	"cloud.dart" = "res://texts/cloud.tres",
}

const extensions = {
	"audio" = [".wav", ".mp3", ".ogg"],
	"image" = [".png", ".jpg", ".jpeg"],
	"text" = [".dart", ".cpp"],
}

func show_view(view_type: String, data: String):
	match view_type:
		"audio":
			audio.show_audio(data)
		
		"image":
			image.show_image(data)
			
		"text":
			text.show_formatted(data)

func update_view(item: TreeItem):
	print("chamou update")
	
	for type_ext in extensions:
		for ext in extensions[type_ext]:
			var item_name = item.get_text(0)
			
			if ext in item_name && view_data[item_name]:
				show_view(type_ext, view_data[item_name])
				return


func _on_tree_item_selected_id(item: TreeItem):
	audio.hide()
	image.hide()
	text.hide()
	var meta = item.get_metadata(0)
	if meta && !meta.blocked:
		update_view(item)
