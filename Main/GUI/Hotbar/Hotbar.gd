extends Control

signal slot1_guh
signal slot2_guh
signal slot3_guh

var slot1: String
var slot2: String
var slot3: String


func _on_slot_1_set_slot_1_item(current_item1) -> void:
	slot1 = current_item1
	slot1_guh.emit(slot1)


func _on_slot_2_set_slot_2_item(current_item2) -> void:
	slot2 = current_item2
	slot2_guh.emit(slot2)


func _on_slot_3_set_slot_3_item(current_item3) -> void:
	slot3 = current_item3
	slot3_guh.emit(slot3)
