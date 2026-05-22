extends CanvasLayer

@onready var instructions = $Control/Buttons/ToolsInstructions
@onready var label = $Control/Buttons/ToolsInstructions/MarginContainer/Label
@onready var docs_b = $Control/Buttons/DocButton
@onready var project_b = $Control/Buttons/ProjectButton
@onready var wrench_b = $Control/Buttons/WrenchButton
@onready var buttons = $Control
@onready var anim_player = $Control/AnimationPlayer 

var saw: Array[String]

const TOOLS_DESC: Dictionary[String, String] = {
	"docs": 
		"Isso veio de fora, tem algumas informações que andei olhando e não 
		estão aqui, mas deve bastar",
	"project": 
		"Tem umas papeladas, uns lugares, não sei, nunca abri",
	"wrench": 
		"Isso vai te deixar ver uma camada abaixo de onde estamos,
		deve ter um jeito delicado de usar ao invés de bater nas coisas",
}

@onready var buttons_pos: Dictionary = {
	"docs": Rect2(docs_b.position, docs_b.size),
	"project": Rect2(project_b.position, project_b.size),
	"wrench": Rect2(wrench_b.position, wrench_b.size),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	docs_b.style_8bit()
	project_b.style_8bit()
	wrench_b.style_8bit()
	

func update_label(event, type: String):
	if event is InputEventScreenTouch && !event.pressed:
		var length = len(saw)
		
		if length < 3:
			instructions.show()
			label.text = TOOLS_DESC[type]
			
			if !type in saw:
				saw.append(type)
		else:
			instructions.queue_free()
			buttons.gui_input.disconnect(_on_buttons_gui_input)
			anim_player.play("button_switch")



func _on_buttons_gui_input(event: InputEvent) -> void:
	if buttons_pos["docs"].has_point(event.position):
		update_label(event, "docs")
	if buttons_pos["project"].has_point(event.position):
		update_label(event, "project")
	if buttons_pos["wrench"].has_point(event.position):
		update_label(event, "wrench")
