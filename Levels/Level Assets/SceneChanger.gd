extends Area2D
#author Ed
signal switch_level
@export var level : String 

signal change

	
func change_level():
	get_tree().change_scene_to_file("res://Levels/" + level + ".tscn")

func _on_body_entered(body):
	if body.name == "Main Character":
		call_deferred("change_level")

