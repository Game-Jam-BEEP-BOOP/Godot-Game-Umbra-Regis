#author Ed
#If collision is not working in inspector go to solver and then enable collision monitoring 
#and set max contacts you want
extends RigidBody2D

var number_frames : int 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_contact_monitor(true)
	set_max_contacts_reported(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_scene() -> void:
	get_parent().get_parent().get_tree().reload_current_scene()
	print("resetting")
	


func _on_body_entered(body: Node) -> void:
	if body.name == "MainCharacter":
		Globals.deaths += 1 #updates death variable in Globals 
		call_deferred("reset_scene")#call deferred as removing object in same frame as physics callback can cause wierd behaviour
		queue_free()	
	else:
		queue_free()
		


func _on_timer_timeout() -> void:
	queue_free()
