extends Node
@export var inventory_item: PackedScene = preload("res://Main/GUI/Inventory/inventory_item.tscn")

var new_item: Node2D
var items_added: Dictionary

# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	manage_inv()


func manage_inv() -> void:
	for i in Globals.stored_items:
		if not items_added.has(i):
			items_added[i] = Globals.stored_items[i]
			create_instance(i)
	
	for i in items_added:
		if not Globals.stored_items.has(i):
			items_added.erase(i)
			destroy_instance(i)


func create_instance(i):
	new_item = inventory_item.instantiate()
	new_item.name = i
	add_child(new_item)
	new_item.set_collision_layer_value(10, true)
	new_item.set_collision_mask_value(10, true)
	new_item.scale = Vector2(0.3,0.3)
	new_item.call(i)
	new_item.slot_picker()
	new_item.start()
	
func destroy_instance(i):
	for child in get_children():
		if child.name == i:
			child.queue_free()
