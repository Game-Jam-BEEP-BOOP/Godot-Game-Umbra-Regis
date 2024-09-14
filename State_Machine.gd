extends Node2D
class_name State

#reference to parent
var parent: Node2D = get_parent()

func enter() -> void:
	pass
	
# Called when the node enters the scene tree for the first time.
func exit() -> void:
	pass

func process_input(event : InputEvent) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null

func process_physics(delta : float) -> State:
	return null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass











