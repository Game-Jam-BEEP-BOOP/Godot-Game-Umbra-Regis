extends Node2D
class_name State

@export var animation_name:String
@export var move_speed: float = 400
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
#reference to parent
var parent: Node2D

func enter() -> void:
	parent.animations.play(animation_name)
	
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











