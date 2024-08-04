extends Control

var isOpen = false

func open() -> void:
	visible = true
	isOpen = true
	get_tree().paused = true

func close() -> void:
	visible = false
	isOpen = false
	get_tree().paused = false
