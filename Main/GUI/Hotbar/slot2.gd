extends Panel
@onready var animated_sprite_2d: AnimatedSprite2D = $Item/AnimatedSprite2D


var assigned: bool = false
var current_item2: String
var slot1: String
var slot3: String

signal set_slot2_item

func _process(_delta) -> void:
	add_to_slot()
	remove_from_slot()


func add_to_slot():
	if Globals.stored_items.has("Potion_of_Humanity") and slot1 != "Potion_of_Humanity" and slot3 != "Potion_of_Humanity" and not assigned:
		animated_sprite_2d.animation = "potion of humanity"
		assigned = true
		current_item2 = "Potion_of_Humanity"
	elif Globals.stored_items.has("Potion_of_Great_Health") and slot1 != "Potion_of_Great_Health" and slot3 != "Potion_of_Great_Health" and not assigned:
		animated_sprite_2d.animation = "potion of great health"
		assigned = true
		current_item2 = "Potion_of_Great_Health"
	elif Globals.stored_items.has("Potion_of_Everlasting_Darkness") and slot1 != "Potion_of_Everlasting_Darkness" and slot3 != "Potion_of_Everlasting_Darkness" and not assigned:
		animated_sprite_2d.animation = "potion of everlasting darkness"
		assigned = true
		current_item2 = "Potion_of_Everlasting_Darkness"
	if assigned:
		set_slot2_item.emit(current_item2)


func remove_from_slot():
	if not Globals.stored_items.has(current_item2) and assigned:
		assigned = false
		current_item2 = "no"
		animated_sprite_2d.animation = "empty"
		set_slot2_item.emit(current_item2)


func _on_slot_1_set_slot_1_item(current_item1) -> void:
	slot1 = current_item1


func _on_slot_3_set_slot_3_item(current_item3) -> void:
	slot3 = current_item3
