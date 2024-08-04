extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer: float
	timer = randi_range(2,5)
	await get_tree().create_timer(timer).timeout
	get_tree().change_scene_to_file("res://Levels/tutorial_scene_1.tscn")
