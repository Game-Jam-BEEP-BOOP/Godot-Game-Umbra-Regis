extends Node


var alchemy_opened: bool = false
var alchemy_closed: bool = false
var but_dont_start_yet: bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.stored_items.has("steel"):
		get_tree().change_scene_to_file("res://Levels/tutorial_scene_6.tscn")
