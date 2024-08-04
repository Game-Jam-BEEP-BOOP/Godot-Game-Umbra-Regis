extends CharacterBody2D

@onready var Player: CharacterBody2D = $"."
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var daggerthrow: PackedScene = preload("res://Main/Dagger Ability/dagger.tscn")
@onready var main_camera: Camera2D = $"Main Camera"


const FLY_SPEED: float = 1000.0
const JUMP_FORCE: int = 550
const HUMAN_JUMP_FORCE: int = 1000
var MOVE_SPEED: float = 400.0
var HUMAN_MOVE_SPEED: float = 250
var GREM_MOVE_SPEED: float = 1000
var OVERCLOCKED_MOVE_SPEED: float = 2000
var ACC: float = 20.0
var FLY_ACC: float = 300.0
var GRAVITY: float = 20.0
var HUMAN_GRAVITY: float = 15.0
var directional_velocity : float = 0
var directional_velocity_x : float = 0
var directional_velocity_y : float = 0
var knockback_direction : Vector2 
var body_name: String
var hotbar_item1: String
var hotbar_item2: String
var hotbar_item3: String


var human: bool = false
var is_input: bool = false
var is_moving:bool = false
var is_idle: bool = false
var is_walking: bool = false
var is_momentumised: bool = false
var is_slowing: bool = false
var is_gremlin_mode: bool = false
var gremlin_buffer: bool = false
var is_in_shadow: bool = false
var is_flying: bool = false
var flying_available: bool = false
var idle_flying: bool = false
var fast_flying: bool = false
var slow_flying: bool = false
var is_gliding: bool = false
var glide_available: bool = true
var dagger_thrown: bool = false
var is_flipped: bool = false
var is_jump_buffer: bool = false
var jumping: bool = false
var just_jumped: bool = false
var trigger_jump:bool = false
var falling: bool = false
var fade: bool = false
var knockback_triggered : bool = false
var shadow_bar_empty: bool = false
var attack: bool = false
var attacking: bool = false
var attack_available: bool = true
var resource_body_entered: bool = false
var resource_broken: bool = false
var can_pickup_resource: bool = false
var ultimate_started: bool = false
var mouse_in_shadow: bool = false
var attack_ended : bool = true
var projectile: bool = false
var weapon: bool = false
var hotbar1: bool = false
var hotbar2: bool = false
var hotbar3: bool = false
var heal : bool = false
var isPhasing : bool = false
var hotbar1_usable: bool = false
var hotbar2_usable: bool = false
var hotbar3_usable: bool = false


signal healthChanged
signal shadow_damage

signal fastfly
signal slowfly
signal idlefly
signal gremlinchange
signal daggerchange
signal fadechange
signal inshadowchange
signal nuh_uh

signal resource_break
signal resource_pick_up

signal attack_time_right
signal attack_time_left
signal player_attack_ended #links to HumanEnemySword
signal reset_sword_attack#links to sword
signal detroit

func _physics_process(delta) -> void:
	if not human:
		if not fade and not ultimate_started:
			my_physics_proces(delta)
		if not ultimate_started:
			move_character()


func _process(_delta) -> void:
	become_detroit()
	if human:
		human_process()
	else:
		if not fade and not ultimate_started:
			my_process()
		animation()
		shadow_fade()
		resource_picked_up()
		melee_attack()
		ult_start()


func set_variables() -> void:
	if not human:
		gremlin_mode()
		slowing()
		momentumised()
		shadow_bar_drain()
		in_shadow()
	attack_or_pickup()
	horizontal_input()
	walk_and_move()
	idle()
	


func my_process():
	set_variables()
	flip()
	dagger_throw()
	hotbar_selection()
	use_potion()
	out_of_da_shadow()


func my_physics_proces(delta):
	flying()
	fly(delta)
	glide()
	basic_movement()
	jump_buffer()
	gravity()


func human_process():
	set_variables()
	walk_and_move()
	idle()
	human_sprint()
	human_movement()
	human_animation()
	flip()
	gravity()
	move_character()

func gravity() -> void:
	if not is_flying and not human and not isPhasing:
		velocity.y += GRAVITY
	if human:
		velocity.y += HUMAN_GRAVITY
		

func horizontal_input() -> void:
	if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		is_input = true
	else:
		is_input = false


func gremlin_mode() -> void:
	#add alchemy upgrades - WIP
	if not shadow_bar_empty and not attacking:
		if Input.is_action_just_pressed("Gremlin Mode") and not is_idle and is_on_floor():
			is_gremlin_mode = true


		if Input.is_action_just_pressed("Gremlin Mode") and not is_on_floor():
			gremlin_buffer = true
			

		if Input.is_action_just_released("Gremlin Mode") || (not is_on_floor() and not gremlin_buffer):
			is_gremlin_mode = false
			gremlin_buffer = false


		if gremlin_buffer and is_on_floor() and not is_idle:
			is_gremlin_mode = true
			gremlin_buffer = false
		elif is_idle:
			gremlin_buffer = false


func momentumised() -> void:
	if (velocity.x > MOVE_SPEED || velocity.x < -MOVE_SPEED) and not is_gremlin_mode:
		is_momentumised = true
	else:
		is_momentumised = false


func idle() -> void:
	if velocity.x == 0 and is_on_floor():
		is_idle = true
	else:
		is_idle = false


func walk_and_move() -> void:
	#if moving on floor and below max speed and not in gremlin mode, sets the character to walking mode
	if (velocity.x > 1 || velocity.x < -1):
		is_moving = true
	else:
		is_moving = false
	if is_moving and not is_momentumised and is_input and not is_gremlin_mode and is_on_floor() and not is_flying:
		is_walking = true
	elif is_input and is_idle and not is_flying:
		is_walking = true
	else:
		is_walking = false


func slowing() -> void:
	if is_input and is_momentumised and not is_gremlin_mode and is_on_floor():
		is_slowing = true
	elif Input.is_action_pressed("right") and velocity.x < -200 and is_walking and is_on_floor():
		is_slowing = true
	elif Input.is_action_pressed("left") and velocity.x > 200 and is_walking and is_on_floor():
		is_slowing = true
	elif not is_momentumised and not is_walking and is_moving and (velocity.x > 200 || velocity.x < -200) and is_on_floor():
		is_slowing = true
	else:
		is_slowing = false


func basic_movement() -> void:
	#normal walking will accelerate only to max walking speed (right)
	if Input.is_action_pressed("right") and is_walking and not isPhasing:
		if velocity.x > 0 || velocity.x == 0:
			velocity.x = min(velocity.x + ACC, MOVE_SPEED)
		if velocity.x < 0:
			velocity.x = velocity.x + (ACC * 1.5)


	#normal walking will accelerate only to max walking speed (left)
	elif Input.is_action_pressed("left")and is_walking and not isPhasing:
		if velocity.x < 0 || velocity.x == 0:
			velocity.x = max(velocity.x - ACC, -MOVE_SPEED)
		if velocity.x > 0:
			velocity.x = velocity.x - (ACC * 1.5)


	#gremlin mode will accelerate only to max gremlin speed (right)
	elif Input.is_action_pressed("right") and is_gremlin_mode and not isPhasing:
		if velocity.x > 0:
			velocity.x = min(velocity.x + ACC, GREM_MOVE_SPEED)
		if velocity.x < 0:
			is_gremlin_mode = false


	#gremlin mode will 	accelerate only to max gremlin speed
	elif Input.is_action_pressed("left")and is_gremlin_mode and not isPhasing:
		if velocity.x < 0:
			velocity.x = max(velocity.x - ACC, -GREM_MOVE_SPEED)
		if velocity.x > 0:
			is_gremlin_mode = false


	#if travelling above max walking speed and are now walking, will slow until max walking speed
	
	elif not is_on_floor() and not is_flying and not isPhasing:
		if Input.is_action_pressed("right"):
			if velocity.x > 200:
				velocity.x = velocity.x
			else:
				velocity.x = velocity.x + ACC
		elif Input.is_action_pressed("left"):
			if velocity.x < - 200:
				velocity.x = velocity.x
			else:
				velocity.x = velocity.x - ACC
		else:
			if velocity.x < 0:
				if Input.is_action_pressed("right"):
					velocity.x = velocity.x + ACC
				elif velocity.x < -10:
					velocity.x = velocity.x + lerp(1.0, 0.0, 0.0001)
			elif velocity.x > 0:
				if Input.is_action_pressed("left"):
					velocity.x = velocity.x - ACC
				elif velocity.x > 10:
					velocity.x = velocity.x - lerp(1.0, 0.0, 0.0001)
	elif isPhasing:
		velocity.x = (velocity.x/abs(velocity.x)) * 100
		velocity.y = 0


	elif is_momentumised and is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.01)


	#if velocity decreases to max walking speed, decceleration quickens until a velocity of 50
	elif (velocity.x > 50 || velocity.x < -50)and is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.03)


	#if velocity decreases to 50 it will deccelerate much quicker to a stop
	elif ((velocity.x < 50) || (velocity.x > -50)) and is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.8)
	


	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_slowing = false
		jump()
		jumping = true
	elif Input.is_action_just_pressed("jump") and not is_flying and not knockback_triggered:
		is_jump_buffer = true
		jump()
	
	if Input.is_action_just_released("jump") and jumping and velocity.y < -250 and not knockback_triggered :
			velocity.y = -350


func human_movement() -> void:
	#normal walking will accelerate only to max walking speed (right)
	if Input.is_action_pressed("right"):
		if velocity.x > 0 || velocity.x == 0:
			velocity.x = min(velocity.x + ACC, HUMAN_MOVE_SPEED)
		if velocity.x < 0:
			velocity.x = velocity.x + ACC


	#normal walking will accelerate only to max walking speed (left)
	elif Input.is_action_pressed("left"):
		if velocity.x < 0 || velocity.x == 0:
			velocity.x = max(velocity.x - ACC, -HUMAN_MOVE_SPEED)
		if velocity.x > 0:
			velocity.x = velocity.x - ACC
	
	elif is_moving:
		velocity.x = lerp(velocity.x, 0.0, 0.5)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		jumping = true


func human_sprint():
	if Input.is_action_pressed("Gremlin Mode"):
		HUMAN_MOVE_SPEED = 700
	else:
		HUMAN_MOVE_SPEED = 350


func jump() -> void:
	if not is_jump_buffer:
		jump_delay()
		trigger_jump = true
		if human:
			velocity.y -= HUMAN_JUMP_FORCE
		else:
			velocity.y -= JUMP_FORCE
			await get_tree().create_timer(0.3).timeout
			trigger_jump = false
	elif is_jump_buffer:
		get_tree().create_timer(0.2).timeout.connect(jump_buffer_timeout)
	jumping = false


func jump_buffer() -> void:
	if is_jump_buffer and is_on_floor():
		is_jump_buffer = false
		jump()


func jump_buffer_timeout() -> void:
	is_jump_buffer = false


func jump_delay() -> void:
	just_jumped = true
	await get_tree().create_timer(0.2).timeout
	just_jumped = false


func flip() -> void:
	if (velocity.x > 1 || velocity.x < -1):
		var left: int = velocity.x < 0
		animated_sprite_2d.flip_h = left
		if velocity.x > 1:
			is_flipped = false
		if velocity.x < -1:
			is_flipped = true


func flying() -> void:
	#add alchemy upgrades - WIP 
	if shadow_bar_empty and not attacking:
		is_flying = false
		flying_available = false
		animated_sprite_2d.rotation = 0
	else:
		flying_available = true
	
	if is_on_floor() and is_flying:
		if is_on_floor():
			is_flying = false
			animated_sprite_2d.rotation = 0
	
	if Input.is_action_just_pressed("Air Drop"):
		if is_flying:
			is_flying = false
			is_gliding = false
			animated_sprite_2d.rotation = 0


	if Input.is_action_just_pressed("fly") and flying_available and not is_flying:
		is_gliding = false
		is_flying = true


func fly(delta: float) -> void:
	if is_flying:
		if velocity.x > 0:
			velocity.x = min(velocity.x, FLY_SPEED)
		if velocity.y > 0:
			velocity.y = min(velocity.y, FLY_SPEED)
		if velocity.x < 0:
			velocity.x = max(velocity.x, -FLY_SPEED)
		if velocity.y < 0:
			velocity.y = max(velocity.y, -FLY_SPEED)
			
		if Input.is_action_pressed("fly"):
			var mouse_position = get_global_mouse_position()
			var direction = (mouse_position - global_position).normalized()
			var acceleration = direction * FLY_ACC * delta
			velocity += acceleration
			if velocity.length() > FLY_SPEED:
				velocity = velocity.normalized() * FLY_SPEED
		
		if Input.is_action_pressed("jump"):
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.y = lerp(velocity.y, 0.0, 0.2)
		fly_idle()
		fly_slow()
		fly_fast()
	else:
		not_flying()
			
func fly_idle() -> void:
	if (velocity.x < 20 and velocity.x > -20) || (velocity.y < 10000 and velocity.y > -20):
		idle_flying = true
		animated_sprite_2d.rotation = 0
	else:
		idle_flying = false

func fly_slow() -> void:
	if ((velocity.x > 20 || velocity.x < -20) and (velocity.x < 250 and velocity.x > -250)) || (velocity.y < -20 and velocity.y > -250):
		slow_flying = true
	else:
		slow_flying = false
	
func fly_fast() -> void:
	if velocity.x > 250 || velocity.x < -250 || velocity.y < -250:
		fast_flying = true
	else:
		fast_flying = false
		
func not_flying() -> void:
	idle_flying = false
	slow_flying = false
	fast_flying = false
	animated_sprite_2d.rotation = 0


func glide() -> void:
	if (Input.is_action_just_released("jump") and is_gliding) || is_on_floor() || not is_gliding:
		GRAVITY = 20
		is_gliding = false
		
	if is_on_floor() || is_in_shadow:
		glide_available = true
		
	if Input.is_action_just_pressed("jump") and not is_flying and not is_on_floor() and glide_available:
		await get_tree().create_timer(0.1).timeout
		if not just_jumped:
			if velocity.y < 0:
				velocity.y = max(-100,velocity.y)
			else:
				velocity.y = 0
			GRAVITY = 1
			is_gliding = true
			glide_available = false
		else:
			is_gliding = false


func dagger_throw() -> void:
	#add alchemy upgrades - WIP
	if Input.is_action_just_pressed("Throw Dagger") and not shadow_bar_empty:
		var dagger = daggerthrow.instantiate()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		dagger_thrown = true
		if is_flipped:
			dagger.rotation = 3.14159265359
		else:
			dagger.rotation = 0
	else:
		dagger_thrown = false


func shadow_fade() -> void:
	#add alchemy upgrades - WIP
	if Input.is_action_just_pressed("Shadow Fade") and is_in_shadow and not shadow_bar_empty:
		fade = true
		is_flying = false
		velocity.x = 0
		velocity.y = 0
		animated_sprite_2d.rotation = 0
		
	if Input.is_action_just_released("Shadow Fade") and fade:
		fade = false

func attack_or_pickup() -> void:
	if Input.is_action_just_pressed("Attack") and not ultimate_started:
		if resource_body_entered:
			break_resource()
		else:
			attacking = true
	

func melee_attack() -> void:
	if attacking and attack_available and not is_flipped and not is_flying and not is_gliding and not is_gremlin_mode:
		attack = true
		attack_available = false
		attacking = false
		attack_time_right.emit()
		await get_tree().create_timer(0.2).timeout
		attack_available = true

	if attacking and attack_available and is_flipped and not is_flying and not is_gliding and not is_gremlin_mode:
		attack = true
		attack_available = false
		attacking = false
		attack_time_left.emit()
		await get_tree().create_timer(0.2).timeout
		attack_available = true


func ult_start() -> void:
	if Input.is_action_just_pressed("Ultimate") and not is_gliding and not is_gremlin_mode and Globals.currentShadow == Globals.maxShadow:
		ultimate_started = true
		var timer = get_tree().create_timer(1).timeout.connect(ultimate_timeout)
	if Input.is_action_just_pressed("Attack") and ultimate_started:
		ultimate_started = false
		if mouse_in_shadow:
			var mouse_position = get_global_mouse_position()
			#fading animation
			Player.position = mouse_position
			#appearing animation


func ultimate_timeout() -> void:
	ultimate_started = false


func become_detroit() -> void:
	if human:
		is_flying = false
		is_gliding = false
		is_gremlin_mode = false
		is_momentumised = false
		animated_sprite_2d.rotation = 0


func animation() -> void:
	if is_walking and not isPhasing and not is_idle:
		animated_sprite_2d.animation = "Walk"
	if is_idle and is_on_floor():
		animated_sprite_2d.animation = "Idle"
	if trigger_jump:
		animated_sprite_2d.animation = "Jump"
	if velocity.y > 0 and not is_flying and not is_gliding and not isPhasing:
		animated_sprite_2d.animation = "Going Up"
	if velocity.y < 0 and not is_flying and not is_gliding and not isPhasing:
		animated_sprite_2d.animation = "Falling"
	if is_gremlin_mode and is_on_floor() and not is_idle:
		animated_sprite_2d.animation = "Gremlin Mode"
	if is_slowing and not is_gremlin_mode and is_on_floor() and not isPhasing and not is_idle:
		animated_sprite_2d.animation = "Slowing"
	if is_flying and (velocity.x > 175 || velocity.x < -175 || velocity.y > 175 || velocity.y < -175) and not is_idle:
		animated_sprite_2d.animation = "Flying"
		animated_sprite_2d.rotation = (velocity.normalized().angle() + rad_to_deg(45))
	if is_flying and not (velocity.x > 175 || velocity.x < -175 || velocity.y > 175 || velocity.y < -175) and not is_idle:
		animated_sprite_2d.animation = "Idle Flying"
	if is_gliding and not is_idle:
		animated_sprite_2d.animation = "Gliding"
	if dagger_thrown and not is_idle:
		animated_sprite_2d.animation = "Dagger Throw"
	if fade and not is_idle:
		animated_sprite_2d.animation = "Fading"
		#ADD TIMER FOR ANIMATION TO PLAY
		animated_sprite_2d.animation = "Faded"
	if knockback_triggered:
		pass
	if ultimate_started:
		animated_sprite_2d.animation = "Teleport"
	if isPhasing and not is_idle:
		animated_sprite_2d.animation = "Phase"


func human_animation():
	if is_walking:
		animated_sprite_2d.animation = "Walk"
	if is_idle:
		animated_sprite_2d.animation = "Idle"
	if not is_on_floor():
		animated_sprite_2d.animation = "Jump"


func _on_shadow_body_entered(body) -> void:
	if body.name == "Main Character":
		is_in_shadow = true
		shadow_bar_empty = false


func _on_shadow_body_exited(body) -> void:
	if body.name == "Main Character":
		is_in_shadow = false


func in_shadow() -> void:
	if is_in_shadow:
		if not is_on_floor():
			glide_available = true


func move_character() -> void:
	move_and_slide()


func shadow_bar_drain() -> void:
	if fast_flying:
		fastfly.emit()
	if slow_flying:
		slowfly.emit()
	if idle_flying:
		idlefly.emit()
	if is_gremlin_mode:
		gremlinchange.emit()
	if dagger_thrown:
		daggerchange.emit()
	if fade:
		fadechange.emit()
	if is_in_shadow and not fade:
		inshadowchange.emit()
	if not is_flying and not is_gremlin_mode and not dagger_thrown and not fade and not is_in_shadow:
		nuh_uh.emit()


func hotbar_selection():
	if Input.is_action_just_pressed("hotbar 1"):
		hotbar1 = true
		hotbar2 = false
		hotbar3 = false
	if Input.is_action_just_pressed("hotbar 2"):
		hotbar1 = false
		hotbar2 = true
		hotbar3 = false
	if Input.is_action_just_pressed("hotbar 3"):
		hotbar1 = false
		hotbar2 = false
		hotbar3 = true


func use_potion() -> void:
	if Input.is_action_just_pressed("Use Potion"):
		if hotbar1 and hotbar1_usable:
			call(hotbar_item1)
			Globals.stored_items[hotbar_item1] -= 1
			if not Globals.stored_items.has(hotbar_item1):
				hotbar1 = false
				hotbar1_usable = false
		if hotbar2 and hotbar2_usable:
			call(hotbar_item2)
			Globals.stored_items[hotbar_item2] -= 1
			if not Globals.stored_items.has(hotbar_item2):
				hotbar2 = false
				hotbar2_usable = false
		if hotbar3 and hotbar3_usable:
			call(hotbar_item3)
			Globals.stored_items[hotbar_item3] -= 1
			if not Globals.stored_items.has(hotbar_item3):
				hotbar3 = false
				hotbar3_usable = false


func Potion_of_Humanity():
	human = true
	await get_tree().create_timer(30).timeout
	human = false


func Potion_of_Great_Health():
	heal = true
	healthChanged.emit(weapon,projectile,heal)
	heal = false

func Potion_of_Everlasting_Darkness():
	Globals.maxShadow = Globals.maxShadow + 20


func out_of_da_shadow():
	if not is_in_shadow:
		shadow_damage.emit()


func _on_gui_shadow_bar_empty() -> void:
	shadow_bar_empty = true
	is_flying = false
	is_gremlin_mode = false
	fade = false


# kezs bar stuff
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(11) == true && area.is_in_group("Projectiles"):
		projectile = true
		healthChanged.emit(projectile, weapon,heal)
		projectile = false


func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.get_collision_layer_value(9) == true && area.is_in_group("Swords"):
		if attack_ended:
			weapon = true
			reset_sword_attack.emit()
			healthChanged.emit(projectile, weapon,heal)
			attack_ended = false
			weapon = false
		

	

# item collecting
func _on_gathering_area_body_entered(body: Node2D) -> void:
	if body.get_collision_layer_value(6) == true:
		resource_body_entered = true
		body_name = body.current_item


func _on_gathering_area_body_exited(body: Node2D) -> void:
	if body.get_collision_layer_value(6) == true:
		resource_body_entered = false


func break_resource() -> void:
	if Input.is_action_just_pressed("Attack") and resource_body_entered:
		resource_body_entered = false
		resource_broken = true
		resource_break.emit()


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.get_collision_layer_value(6):
		can_pickup_resource = true


func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body.get_collision_layer_value(6):
		can_pickup_resource = false


func resource_picked_up() -> void:
		if can_pickup_resource and resource_broken:
			can_pickup_resource = false
			resource_broken = false
			resource_pick_up.emit()


func _on_shadow_mouse_entered() -> void:
	mouse_in_shadow = true


func _on_shadow_mouse_exited() -> void:
	mouse_in_shadow = false



func _on_player_sword_player_attack_ended() -> void:
	player_attack_ended.emit()


func _on_gui_slot_1_item(slot1) -> void:
	hotbar_item1 = slot1
	hotbar1_usable = true


func _on_gui_slot_2_item(slot2) -> void:
	hotbar_item2 = slot2
	hotbar2_usable = true


func _on_gui_slot_3_item(slot3) -> void:
	hotbar_item3 = slot3
	hotbar3_usable = true


func _on_phasable_wall_body_entered(body: Node2D) -> void:
	if body.name == "Main Character":
		isPhasing = true




func _on_phasable_wall_body_exited(body: Node2D) -> void:
	if body.name == "Main Character":
		isPhasing = false



func _on_human_enemy_sword_attack_end() -> void:
	attack_ended = true
