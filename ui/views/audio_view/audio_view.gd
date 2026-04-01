extends Control

@onready var play_btn: Button = $"VBoxContainer/Audio Control/PlayButton"
@onready var pause_btn: Button = $"VBoxContainer/Audio Control/PauseButton"
@onready var player: AudioStreamPlayer = $"VBoxContainer/Audio Control/AudioStreamPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func show_audio(resource_path = null):
	if resource_path is String:
		player.stream = load(resource_path)
		show()
	else:
		player.stream = null


func _on_play_button_up():
	if player.stream: 
		player.play()


func _on_pause_button_up():
	if player.playing:
		player.stop()
