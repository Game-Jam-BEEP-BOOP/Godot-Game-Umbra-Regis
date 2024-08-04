extends RayCast2D

signal RayCastNotColliding
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(str(enabled) +  " Enabled")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (not is_colliding()):
		RayCastNotColliding.emit()
