extends CharacterBody2D
@onready var main_menu_visualiser: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $"animated sprite 2D"

signal boom

var start_pos: Vector2 = Vector2(721, -259)
var started: bool = false
var left: bool
var mouse: bool = false
var pause: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	initialise()
	if started and not pause:
		bounce_time()
		move_and_slide()
		click()
	
func initialise():
	if not started:
		main_menu_visualiser.position = start_pos
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
	
func click():
	if Input.is_action_just_pressed("Attack") and mouse:
		var stored_velocity = velocity
		boom.emit()
		set_collision_layer_value(32, false)
		set_collision_mask_value(32, false)
		animated_sprite_2d.animation = "boom"
		await get_tree().create_timer(0.1).timeout
		animated_sprite_2d.animation = "gone"
		main_menu_visualiser.position = start_pos
		pause = true
		await get_tree().create_timer(10).timeout
		animated_sprite_2d.animation = "default"
		set_collision_layer_value(32, true)
		set_collision_mask_value(32, true)
		pause = false
		velocity = stored_velocity


func _on_mouse_entered() -> void:
	mouse = true


func _on_mouse_exited() -> void:
	mouse = false
