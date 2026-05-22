extends Tree

@export var handler: Control
@onready var tree: Tree = self

signal item_selected_id(item: TreeItem)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_structure()
	if handler:
		tree.item_selected_id.connect(handler._on_tree_item_selected_id)

# Creates the directiory tree structure manually
func tree_structure():
	# Resources
	var dir_icon = preload("res://ui/modals/project_window/dir.png")
	var blocked_dir = preload("res://ui/modals/project_window/dir_block.png")
	var blocked_code = preload("res://ui/modals/project_window/padlock.png")
	var dart_icon = preload("res://ui/modals/project_window/dart.png")
	var img_icon = preload("res://ui/modals/project_window/image.png")
	var sound_icon = preload("res://ui/modals/project_window/sound.png")
	
	# Tree configs
	tree.clear()
	tree.columns = 1
	tree.item_collapsed.connect(_on_item_collapsed)
	
	# Structure
	# Root
	var root: TreeItem = tree.create_item()
	root.set_text(0, "Flute_backdoor_403")
	root.set_icon(0, dir_icon)
	
	# First layer
	new_tree_item(root, "android", blocked_dir)
	var editable_asset = new_tree_item(root, "assets", dir_icon, false)
	new_tree_item(root, "build", blocked_dir)
	new_tree_item(root, "ios", blocked_dir)
	var editable_lib = new_tree_item(root, "lib", dir_icon, false)
	new_tree_item(root, "linux", blocked_dir)
	new_tree_item(root, "macos", blocked_dir)
	new_tree_item(root, "test", blocked_dir)
	new_tree_item(root, "web", blocked_dir)
	new_tree_item(root, "windows", blocked_dir)
	new_tree_item(root, ".metadata", blocked_code, false)
	new_tree_item(root, "flutteria_world.iml", blocked_code, false)
	new_tree_item(root, "pubspec.lock", blocked_code, false)
	new_tree_item(root, "pubspec.yaml", blocked_code, false)
	new_tree_item(root, "README.md", blocked_code, false)
	
	
	
	# Second layer
	var editable_src = new_tree_item(editable_lib, "src", dir_icon, false)
	new_tree_item(editable_lib, "main.dart", dart_icon, false)
	
	var editable_img = new_tree_item(editable_asset, "img", dir_icon, false)
	var editable_sfx = new_tree_item(editable_asset, "sfx", dir_icon, false)
	new_tree_item(editable_asset, "vfx", blocked_dir)
	
	# Third layer
	new_tree_item(editable_src, "background.dart", dart_icon, false)
	new_tree_item(editable_src, "cloud.dart", dart_icon, false)
	new_tree_item(editable_src, "hud.dart", dart_icon, false)
	new_tree_item(editable_src, "joystick.dart", dart_icon, false)
	new_tree_item(editable_src, "life.dart", dart_icon, false)
	new_tree_item(editable_src, "player.dart", dart_icon, false)
	
	
	new_tree_item(editable_img, "chars", blocked_dir)
	new_tree_item(editable_img, "itens", blocked_dir)
	new_tree_item(editable_img, "skills", blocked_dir)
	new_tree_item(editable_img, "weapons", blocked_dir)
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
	else:
		item.set_metadata(0, {"blocked" : false})
	
	item.set_collapsed(true)
	return item

# Handles try of open blocked folders
func _on_item_collapsed(item: TreeItem):
	var meta = item.get_metadata(0)
	
	if meta && meta.blocked:
		item.set_collapsed(true)


func _on_item_selected() -> void:
	var item = get_selected()
	item_selected_id.emit(item)
