extends Node


func _process(delta: float) -> void:
	if Input.is_action_just_released("Shadow Fade"):
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_file("res://Levels/Level1.tscn")
