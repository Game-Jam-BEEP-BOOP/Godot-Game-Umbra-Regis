extends Area2D
@onready var Sword: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_collsion: CollisionShape2D = $SwordCollsion
signal player_attack_ended

var right_position: Vector2 = Vector2(46, 6)
var left_position: Vector2 = Vector2(-42, 10)


var gogo_attack_right: bool = false
var gogo_attack_left: bool = false

func _process(_delta):
	if gogo_attack_right:
		attack_right()
	if gogo_attack_left:
		attack_left()

func attack_right() -> void:
	Sword.position = right_position
	sword_collsion.disabled = false
	animated_sprite_2d.animation = "Visible"
	if Sword.rotation < deg_to_rad(140):
		Sword.rotation = Sword.rotation + deg_to_rad(2)
	if Sword.rotation > deg_to_rad(140):
		sword_collsion.disabled = true
		animated_sprite_2d.animation = "Invisible"
		gogo_attack_right = false
		print("ended")
		player_attack_ended.emit()


func attack_left() -> void:
	Sword.position = left_position
	sword_collsion.disabled = false
	animated_sprite_2d.animation = "Visible"
	if Sword.rotation > deg_to_rad(220):
		Sword.rotation = Sword.rotation - deg_to_rad(2)
	if Sword.rotation < deg_to_rad(220):
		print("ended")
		sword_collsion.disabled = true
		animated_sprite_2d.animation = "Invisible"
		gogo_attack_left = false
		player_attack_ended.emit()


func _on_character_body_2d_attack_time_right() -> void:
	Sword.rotation = deg_to_rad(15)
	gogo_attack_right = true


func _on_character_body_2d_attack_time_left() -> void:
	Sword.rotation = deg_to_rad(345)
	gogo_attack_left = true


func _on_main_character_reset_sword_attack() -> void:
	Sword.rotation = deg_to_rad(0)
	await  get_tree().create_timer(1)
