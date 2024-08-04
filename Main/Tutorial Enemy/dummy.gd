extends Area2D

var requirements: int = 0
var enter: bool = false
var sword: bool = false
var dagger: bool = false

func _on_body_entered(body: Node2D) -> void:
	enter = true


func _process(_delta) -> void:
	hit()
	if requirements == 2:
		get_tree().change_scene_to_file("res://Levels/tutorial_scene_7.tscn")


func _on_body_exited(body: Node2D) -> void:
	enter = false


func hit():
	if enter and Input.is_action_just_pressed("Attack") and not sword:
		sword = true
		requirements += 1
	if Input.is_action_just_pressed("Throw Dagger") and not dagger:
		dagger = true
		requirements += 1
