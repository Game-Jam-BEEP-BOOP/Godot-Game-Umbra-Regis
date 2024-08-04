extends RayCast2D
signal HasLineOfSight
signal NoLineOfSight
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		HasLineOfSight.emit()
		
	if  !is_colliding():
		NoLineOfSight.emit()


