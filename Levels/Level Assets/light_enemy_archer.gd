extends CharacterBody2D
@onready var main_character = get_node("../Main Character")
@onready var main_scene = get_parent().get_node("Projectiles")
@onready var arrow :PackedScene = preload("res://Levels/Level Assets/Arrow.tscn")

var health = 50
var multiplier : Array[int] = [1]
var player_positions : Array[Vector2]= []
var offset_values : Array[int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
var offset_multiplier : Array[int] = [-1,1]
var active : bool = false
var choose_direction : bool = true
var player_pos_changed : bool = false
var player_attack_ended : bool = false
var player_exited_inner : bool = false
var player_entered_inner : bool = false




const SPEED = 300
const JUMP_VELOCITY = -700
var direction : Vector2 #players direction for movement
func _ready() -> void:
	player_positions.resize(2)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
signal postion_arrow#links to Arrow
func _input(event: InputEvent) -> void:
	pass

	
func _physics_process(delta: float) -> void:

	if active:
		var main_character_pos_difference = main_character.position - position
		#gets position in different frames then compares them and if player not moving then move away and stop
		if choose_direction:
			player_positions[0] = main_character.position
		
			if (player_positions[0] == player_positions[1] && (main_character.position - position > Vector2(600,600))):
					velocity = Vector2.ZERO
					return
					
			if player_entered_inner:
				multiplier[0] = -1
				player_entered_inner = false
				choose_direction = false
			elif player_exited_inner:
				multiplier[0] = 1
				player_exited_inner = false
				choose_direction = false
					
		player_pos_changed = false
		player_positions[1]= main_character.position
		print("multiplier " + str(multiplier[0]))
		direction = (main_character.position - position) * multiplier[0]
		velocity = direction * SPEED * delta
		move_and_slide()

func _on_timer_timeout() -> void:
	choose_direction = true


func _on_light_attack_timeout() -> void:
	if active :
		print("attacking")
		var main_character_position_offset_y = main_character.position.y + (offset_values.pick_random() * offset_multiplier.pick_random()) 
		var main_character_position_offset_x = main_character.position.x + (offset_values.pick_random() * offset_multiplier.pick_random())
		var main_character_position_offset = Vector2(main_character_position_offset_x,main_character_position_offset_y)
		#want to get players velocity and have them face correct way
		var arrow_instance = arrow.instantiate()
		arrow_instance.position = self.global_position
		arrow_instance.get_child(0).animation = "Spear"
		
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


func _on_player_toward_body_exited(body: Node2D) -> void:
	print("test")



func _on_player_detection_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.is_in_group("Player")):
		active = true

func _on_player_away_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		player_entered_inner = true


func _on_player_away_body_exited(body: Node2D) -> void:
	print("exited")
	print(str(choose_direction) + " choose direction")
	if (body.is_in_group("Player")):
		player_exited_inner = true
		


