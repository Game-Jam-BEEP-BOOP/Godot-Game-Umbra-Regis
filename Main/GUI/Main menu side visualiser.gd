extends CharacterBody2D
@onready var main_menu_visualiser: CharacterBody2D = $"."


var start_pos: Vector2 = Vector2(1059, 244)
var started: bool = false
var left: bool
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	initialise()
	if started:
		bounce_time()
		move_and_slide()
	
func initialise():
	if not started:
		main_menu_visualiser.position = start_pos
		velocity.x = -700
		left = true
		started = true


func bounce_time():
	if (is_on_wall() || is_on_floor()) and left:
		velocity.x = 700
		left = false
	elif is_on_wall() and not left:
		velocity.x = -700
		left = true
	elif is_on_floor():
		velocity.y = -700
	velocity.y = velocity.y + 3
