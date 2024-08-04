extends Panel

@onready var backgroundsprite: Sprite2D = $Background
@onready var itemsprite: Sprite2D = $CenterContainer/Panel/Item
@export var current_item = preload("res://Items/Resources/Objects/resources.gd")
@onready var slot: Panel = $"."

var slot_empty: bool = true


# should call this somewhere so that the slot colour changes when empty/full
func show_in_inventory() -> void:
	if slot_empty:
		backgroundsprite.frame = 0
		itemsprite.visible = false
	else:
		backgroundsprite.frame = 1
		itemsprite.visible = true

