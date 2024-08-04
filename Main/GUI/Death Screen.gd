extends TextureRect

func _ready() -> void:
	visible = false




func _on_health_bar_ded() -> void:
	visible = true
	await get_tree().create_timer(1).timeout
	visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()
