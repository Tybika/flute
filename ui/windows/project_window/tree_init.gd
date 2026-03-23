extends Control

@onready var tree: Tree = $Window/Content/VBoxContainer/HBoxContainer2/ScrollContainer/Tree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_structure()

# Creates the directiory structure manually
func tree_structure():
	# Resources
	var dir_icon = preload("res://ui/windows/project_window/dir.png")
	var open_icon = preload("res://ui/windows/project_window/dir_open.png")
	var blocked_icon = preload("res://ui/windows/project_window/dir_block.png")
	var dart_icon = preload("res://ui/windows/project_window/dart.png")
	var img_icon = preload("res://ui/windows/project_window/image.png")
	var sound_icon = preload("res://ui/windows/project_window/sound.png")
	
	# Tree configs
	tree.clear()
	tree.columns = 1
	tree.item_collapsed.connect(_on_item_collapsed)
	
	# Structure
	# Root
	var root: TreeItem = tree.create_item()
	root.set_text(0, "Flute_backdoor_403")
	root.set_icon(0, open_icon)
	
	# First layer
	new_tree_item(root, "android", blocked_icon)
	var editable_asset = new_tree_item(root, "assets", dir_icon, false)
	new_tree_item(root, "build", blocked_icon)
	new_tree_item(root, "ios", blocked_icon)
	var editable_lib = new_tree_item(root, "lib", dir_icon, false)
	new_tree_item(root, "linux", blocked_icon)
	new_tree_item(root, "macos", blocked_icon)
	new_tree_item(root, "test", blocked_icon)
	new_tree_item(root, "web", blocked_icon)
	new_tree_item(root, "windows", blocked_icon)
	
	# Second layer
	var editable_src = new_tree_item(editable_lib, "src", dir_icon, false)
	new_tree_item(editable_lib, "main.dart", dart_icon, false)
	
	var editable_img = new_tree_item(editable_asset, "img", dir_icon, false)
	var editable_sfx = new_tree_item(editable_asset, "sfx", dir_icon, false)
	new_tree_item(editable_asset, "vfx", blocked_icon)
	
	# Third layer
	new_tree_item(editable_src, "character.dart", dart_icon, false)
	new_tree_item(editable_src, "enemies.dart", dart_icon, false)
	new_tree_item(editable_src, "gamepad.dart", dart_icon, false)
	new_tree_item(editable_src, "life_counter.dart", dart_icon, false)
	
	new_tree_item(editable_img, "chars", blocked_icon)
	new_tree_item(editable_img, "itens", blocked_icon)
	new_tree_item(editable_img, "skills", blocked_icon)
	new_tree_item(editable_img, "weapons", blocked_icon)
	new_tree_item(editable_img, "background.png", img_icon, false)
	new_tree_item(editable_img, "background_final.png", img_icon, false)
	new_tree_item(editable_img, "coin_icon.png", img_icon, false)
	new_tree_item(editable_img, "life_icon.png", img_icon, false)
	
	new_tree_item(editable_sfx, "coin.wav", sound_icon, false)
	new_tree_item(editable_sfx, "error.wav", sound_icon, false)
	new_tree_item(editable_sfx, "step.wav", sound_icon, false)
	new_tree_item(editable_sfx, "success.wav", sound_icon, false)

# Creates and configure TreeItems
func new_tree_item(parent: TreeItem, text: String, icon: Texture2D = null, 
		closed_folder: bool = true):
	var item = tree.create_item(parent)
	item.set_text(0, text)
	
	if icon:
		item.set_icon(0, icon)
	
	if closed_folder:
		tree.create_item(item).set_text(0, "Não autorizado")
		item.set_metadata(0, {"blocked" : true})
	
	item.set_collapsed(true)
	return item

# Handles try of open blocked folders
func _on_item_collapsed(item: TreeItem):
	var meta = item.get_metadata(0)
	
	if meta && meta.blocked:
		item.set_collapsed(true)

# Handles visualization

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
