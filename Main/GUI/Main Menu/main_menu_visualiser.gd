extends CharacterBody2D
@onready var main_menu_visualiser: CharacterBody2D = $"."


var start_pos: Vector2 = Vector2(717, 534)
var started: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	initialise()
	if started:
		bounce_time()
		move_and_slide()
	
func initialise():
	if not started:
		started = true
		main_menu_visualiser.position = start_pos

func rotate_time():
	await get_tree().create_timer(0.1).timeout
	main_menu_visualiser.rotation = rotation + rad_to_deg(0.1)

func bounce_time():
	if is_on_floor():
		velocity.y = -700
	velocity.y = velocity.y + 20
