extends Node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if Globals.stored_items.has("metal_scraps"):
		await get_tree().create_timer(0.35).timeout
		get_tree().change_scene_to_file("res://Levels/tutorial_scene_8.tscn")
