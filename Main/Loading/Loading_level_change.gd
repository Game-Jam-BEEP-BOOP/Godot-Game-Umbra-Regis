extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activate()


func activate():
	visible = true
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	visible = false
