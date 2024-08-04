extends Area2D
signal ObjectDetected
signal PlayerDetected
var foundPlayer : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if has_overlapping_bodies():
		var bodies = get_overlapping_bodies()
		for i in bodies.size() - 1:
			print(bodies[i].name)
			if bodies[i].name =="MainCharacter":
				foundPlayer = true

		if foundPlayer:
			PlayerDetected.emit()
			foundPlayer = false
		else:
			
			ObjectDetected.emit()
		

