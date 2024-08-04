extends RayCast2D

signal raycast_right_not_colliding
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (is_colliding()):
		raycast_right_not_colliding.emit()
