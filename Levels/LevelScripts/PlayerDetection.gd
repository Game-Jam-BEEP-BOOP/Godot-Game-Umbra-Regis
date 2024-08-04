extends Area2D
signal attack_time_right
signal attack_time_left
@onready var MainCharacter = get_parent().get_parent().get_node("Main Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




#when timer runs out sends signal to attack
func _on_attack_cooldown_timeout() -> void:
		if (overlaps_body(MainCharacter)):
			if (MainCharacter.position.x > get_parent().position.x):
				attack_time_right.emit()
						
			if (MainCharacter.position.x < get_parent().position.x):
				attack_time_left.emit()
						




		
				
						

