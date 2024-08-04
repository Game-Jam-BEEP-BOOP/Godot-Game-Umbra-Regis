extends CanvasLayer




func _on_exit_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_alchemy_screen_begin() -> void:
	visible = true
