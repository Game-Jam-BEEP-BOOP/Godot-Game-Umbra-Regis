extends Node2D

var rock : Resource = preload("res://Levels/Level Assets/rock.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_spawn_timer_timeout() -> void:
	var new_rock : RigidBody2D = rock.instantiate()
	add_child(rock.instantiate())

