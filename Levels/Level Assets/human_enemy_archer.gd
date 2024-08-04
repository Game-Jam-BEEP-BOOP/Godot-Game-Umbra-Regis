extends CharacterBody2D
@onready var main_character = get_node("../Main Character")
@onready var main_scene = get_parent().get_node("Projectiles")
@onready var arrow :PackedScene = preload("res://Levels/Level Assets/Arrow.tscn")

var health = 50
var multiplier : Array[int] = [1]
var player_positions : Array[float]= []
var offset_values : Array[int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
var offset_multiplier : Array[int] = [-1,1]
var active : bool = false
var choose_direction : bool = true
var player_pos_changed : bool = false

var raycast_right_not_colliding : bool = false
var raycast_left_not_colliding : bool = false

var player_attack_ended : bool = false



const SPEED = 3
const JUMP_VELOCITY = -700
var direction : float #players direction for movement
func _ready() -> void:
	player_positions.resize(2)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
signal postion_arrow#links to Arrow
func _input(event: InputEvent) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if active:
		var main_character_pos_difference = main_character.position.x - position.x
		if (main_character_pos_difference < 0):
			main_character_pos_difference *= -1
		#gets position in different frames then compares them and if player not moving then move away and stop
		if choose_direction:
			player_positions[0] = main_character.position.x
		
			if (player_positions[0] == player_positions[1] && (main_character.position.x - position.x > 400)):
					velocity.x = 0
					return

			if (main_character_pos_difference) < 300 :

					print(main_character.position.x - position.x)
			if (main_character_pos_difference) < 300 :
					multiplier[0] = -1
					choose_direction = false

			if(main_character_pos_difference) > 300 :
					print("towards player")
			if(main_character_pos_difference) > 300 :
					multiplier[0] = 1
					choose_direction = false

		player_pos_changed = false
		player_positions[1]= main_character.position.x 
		direction = (main_character.position.x - position.x) * multiplier[0]
		if (raycast_left_not_colliding || raycast_right_not_colliding):
			print("raycast being dumb")
			if ($LedgeTimer.is_stopped()):
				$LedgeTimer.start()
				
			direction *= -1
			
		velocity.x = direction * SPEED
		move_and_slide()

func _on_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
		if(area.is_in_group("Player")): 
				pass



func _on_player_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		active = true


func _on_hitbox_body_entered(body: Node2D) -> void:
		print("body hitbox")
		if (body.is_in_group("Objects")):
			velocity.y = JUMP_VELOCITY

func _on_timer_timeout() -> void:
	choose_direction = true
func _on_arrow_timer_timeout() -> void:
	if active :
		var main_character_position_offset_y = main_character.position.y + (offset_values.pick_random() * offset_multiplier.pick_random()) 
		var main_character_position_offset_x = main_character.position.x + (offset_values.pick_random() * offset_multiplier.pick_random())
		var main_character_position_offset = Vector2(main_character_position_offset_x,main_character_position_offset_y)
		#want to get players velocity and have them face correct way
		print("firing arrows")
		var arrow_instance = arrow.instantiate()
		arrow_instance.get_child(0).animation = "Arrow"
		arrow_instance.position = self.global_position

		arrow_instance.setup(main_character_position_offset - position)
		main_scene.add_child(arrow_instance)



func _on_hitbox_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if (area.is_in_group("Swords") && player_attack_ended):
		health -= 40
		if (health < 0):
			queue_free()
		player_attack_ended = false


func _on_main_character_player_attack_ended() -> void:
	player_attack_ended = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	active = false


func _on_ray_cast_left_raycast_left_not_colliding() -> void:
	raycast_left_not_colliding = true


func _on_ray_cast_right_raycast_right_not_colliding() -> void:
	print("not colliding right")
	raycast_right_not_colliding = true


func _on_ledge_timer_timeout() -> void:
	print("not colliding left")
	raycast_left_not_colliding = false
	raycast_right_not_colliding = false
