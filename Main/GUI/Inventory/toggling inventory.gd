extends CanvasLayer

@onready var inventory = $"Inventory"
@onready var pause_menu = $"Pause Menu"

func _ready() -> void:
	visible = true
	inventory.close()
	pause_menu.close()
	
func _input(event) -> void:
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
	if event.is_action_pressed("pause_game"):
		if pause_menu.isOpen:
			pause_menu.close()
		else:
			pause_menu.open()
