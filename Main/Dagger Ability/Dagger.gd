extends Area2D


const MOVE_SPEED = 1500
var player: Node2D


signal enemy_hit


func _ready():
	player = get_parent().get_node("Main Character")


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += MOVE_SPEED * direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body != player:
		if body.is_in_group("Enemies"):
			enemy_hit.emit()
			
		queue_free()
