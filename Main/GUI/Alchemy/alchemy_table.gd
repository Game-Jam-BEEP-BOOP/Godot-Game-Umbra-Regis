extends Area2D
var alchemy_screen = preload("res://Main/GUI/Alchemy/Alchemy Screen.tscn")

var body_enter: bool = false

signal open_alchemy

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main Character":
		body_enter = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Main Character":
		body_enter = false


func _process(_delta) -> void:
	if Input.is_action_just_pressed("Open_chest") and body_enter:
		open_alchemy.emit()
