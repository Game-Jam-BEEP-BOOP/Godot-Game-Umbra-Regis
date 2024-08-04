extends Panel
@onready var animated_sprite_2d: AnimatedSprite2D = $Item/AnimatedSprite2D


var assigned: bool = false
var current_item1: String
var slot2: String
var slot3: String

signal set_slot1_item

func _process(_delta) -> void:
	add_to_slot()
	remove_from_slot()


func add_to_slot() -> void:
	if Globals.stored_items.has("Potion_of_Humanity") and slot2 != "Potion_of_Humanity" and slot3 != "Potion_of_Humanity" and not assigned:
		animated_sprite_2d.animation = "potion of humanity"
		assigned = true
		current_item1 = "Potion_of_Humanity"
		print("Potion_of_Humanity added")
	elif Globals.stored_items.has("Potion_of_Great_Health") and slot2 != "Potion_of_Great_Health" and slot3 != "Potion_of_Great_Health" and not assigned:
		animated_sprite_2d.animation = "potion of great health"
		assigned = true
		current_item1 = "Potion_of_Great_Health"
		print("Potion_of_Great_Health added")
	elif Globals.stored_items.has("Potion_of_Everlasting_Darkness") and slot2 != "Potion_of_Everlasting_Darkness" and slot3 != "Potion_of_Everlasting_Darkness" and not assigned:
		animated_sprite_2d.animation = "potion of everlasting darkness"
		assigned = true
		current_item1 = "Potion_of_Everlasting_Darkness"
		print("Potion_of_Everlasting_Darkness added slot 1")
	if assigned:
		set_slot1_item.emit(current_item1)
	print(current_item1)


func remove_from_slot() -> void:
	if not Globals.stored_items.has(current_item1) and assigned:
		assigned = false
		current_item1 = "no"
		animated_sprite_2d.animation = "empty"
		set_slot1_item.emit(current_item1)


func _on_slot_2_set_slot_2_item(current_item2) -> void:
	slot2 = current_item2


func _on_slot_3_set_slot_3_item(current_item3) -> void:
	slot3 = current_item3
