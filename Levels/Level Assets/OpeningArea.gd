#WARNING DO NOT MOVE THE ORDER OF MAIN CHARACTER IN LEVEL Master if you do this will break if you 
#really need to make sure u change the overlaps body function to the new location of MainCharacter
extends Area2D
@onready var inventory = get_parent().get_child(0).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	#overlaps body gets MainCharacter based on file tree
	if event.is_action_pressed("Open_chest") and overlaps_body(get_parent().get_parent().get_child(1)):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
		
