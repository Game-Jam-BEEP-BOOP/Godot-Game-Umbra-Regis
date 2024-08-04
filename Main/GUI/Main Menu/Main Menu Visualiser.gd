extends Area2D
@onready var main_menu_visualiser: Area2D = $"."

var start_pos: Vector2 = Vector2(25, -6)
var started: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	initialise()
	rotate()
	
func initialise():
	if not started:
		started = true
		main_menu_visualiser.position = start_pos

func rotate():
	rotation = rotation + rad_to_deg(0.1)

func bounce():
	if main_menu_visualiser.position == start_pos:
		velocity.y = -700
	velocity.y = velocity.y + 20
