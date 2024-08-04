extends Area2D


const SPEED : int = 10
var direction : Vector2 

func setup(dir) -> void:#dir = direction
	direction = dir
	rotation = dir.angle()

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
