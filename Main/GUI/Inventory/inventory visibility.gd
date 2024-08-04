extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var inv_count: int

# togle
var isOpen: bool = false


func _ready():
	pass

func _process(_delta) -> void:
	pass

func open() -> void:
	visible = true
	isOpen = true
	get_tree().paused = true

func close() -> void:
	visible = false
	isOpen = false
	get_tree().paused = false
