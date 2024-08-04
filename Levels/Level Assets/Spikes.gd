#author Ed
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resetScene() -> void:
	get_parent().get_tree().reload_current_scene()
	
	
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Main Character":
		Globals.deaths += 1 #updates death variable in Globals
		call_deferred("resetScene")#call deferred as removing object in same frame as physics callback can cause wierd behaviour
		
	else :#if enemies go over it it just deletes/kills them
		body.queue_free()
		
