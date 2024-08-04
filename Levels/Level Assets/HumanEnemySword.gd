extends CharacterBody2D
@onready var main_character = get_node("../Main Character")
var health : int = 100
var attacking : bool = false
var attack : bool = false 
var active : bool = false
var attack_avaliable : bool = true
var player_attack_ended : bool = false#tells enemy whether it is being attacked or not
var right_raycast_not_colliding : bool = false
var left_raycast_not_colliding : bool = false

var jumping : bool = false



signal freezeSword#links to enemy_sword
signal attack_end#links to main character


const SPEED = 3
const JUMP_VELOCITY = -700

func  _process(delta: float) -> void:
	pass

func _ready() -> void:
	pass
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event: InputEvent) -> void:
	pass

	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if active:
		var direction : float
		if jumping:
				if $JumpTimer.is_stopped():
					$JumpTimer.start()
				
					
		if ((right_raycast_not_colliding || left_raycast_not_colliding) && !jumping):
				if  $LedgeMoveAway.is_stopped():
					$LedgeMoveAway.start()
				
				direction = (main_character.position.x - position.x) * -1
		else:	
				direction = (main_character.position.x - position.x)
		velocity.x = direction * SPEED 
		move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		active = true
	
	if (body.is_in_group("Projectiles")):
		print("hit")



func _on_hitbox_body_entered(body: Node2D) -> void:
		if (body.is_in_group("Objects")):
			velocity.y = JUMP_VELOCITY
			jumping = true
			




func _on_sword_attack_end() -> void:
	attack_end.emit()


func _on_main_character_player_attack_ended() -> void:
	player_attack_ended = true


func _on_hitbox_area_exited(area: Area2D) -> void:
		print("test")
		if (player_attack_ended):
			health -= 10
			print("losing health")
			freezeSword.emit()
			player_attack_ended = false
			if (health == 0):
				queue_free()






func _on_ray_cast_left_ray_cast_not_colliding() -> void:
	print("left not colliding sword")
	right_raycast_not_colliding = true


func _on_ray_cast_right_right_ray_cast_not_colliding() -> void:
	print("right not colliding sword")
	left_raycast_not_colliding = true


func _on_ledge_move_away_timeout() -> void:
	left_raycast_not_colliding = false
	right_raycast_not_colliding = false

func _on_jump_timer_timeout() -> void:
	jumping = false
	left_raycast_not_colliding = false
	right_raycast_not_colliding = false
