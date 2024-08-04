extends Area2D

var inv_count: int

var stored_items = Globals.stored_items


func _ready() -> void:
	pass


func _process(_delta) -> void:
	pass


func update_inventory() -> void:
	if inv_count < stored_items.size():     #if there are less item TYPES in inventory than there should be
		for i in stored_items:              #checks through stored_items in global
			#find which item is missing from inventory and add an instance of Area2D as that item (see resources for instances)
			pass
	if inv_count > stored_items.size():    #if there are less item TYPES than their were
		#find which item and remove it from stored_items in global
		pass
	#create another check for if the amount of the item type changes and edit the amount in globals
