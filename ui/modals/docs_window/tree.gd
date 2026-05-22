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
	# Tree configs
	tree.clear()
	tree.columns = 1
	tree.item_collapsed.connect(_on_item_collapsed)
	
	# Structure
	# Root
	var root: TreeItem = tree.create_item()
	
	# First layer
	var dart = new_tree_item(root, "dart")
	var flutter = new_tree_item(root, "flutter")
	
	# Second layer dart
	new_tree_item(dart, "Classes")
	new_tree_item(dart, "List")
	new_tree_item(dart, "Operadores")
	
	# Second layer flutter
	new_tree_item(flutter, "ColorScheme")
	new_tree_item(flutter, "Container")
	new_tree_item(flutter, "Image")
	new_tree_item(flutter, "MaterialApp")
	new_tree_item(flutter, "Row")
	new_tree_item(flutter, "ThemeData")
	new_tree_item(flutter, "Widget")
	new_tree_item(flutter, "Joystick")
	
	


# Creates and configure TreeItems
func new_tree_item(parent: TreeItem, text: String):
	var item = tree.create_item(parent)
	item.set_text(0, text)
	
	item.set_collapsed(false)
	return item

# Handles try of open blocked folders
func _on_item_collapsed(item: TreeItem):
	var meta = item.get_metadata(0)
	
	if meta && meta.blocked:
		item.set_collapsed(true)


func _on_item_selected() -> void:
	var item = get_selected()
	item_selected_id.emit(item)
