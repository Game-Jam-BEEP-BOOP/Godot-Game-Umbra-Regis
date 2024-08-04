extends Area2D
@onready var Sword: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_collision: CollisionShape2D = $CollisionShape2D
signal  attack_end
var attacking_left : bool = false
var attacking_right : bool =  false
var right_position: Vector2 = Vector2(46, 6)
var left_position: Vector2 = Vector2(-42, 10)



func _process(_delta):
	if attacking_right:
		attack_right()
	if attacking_left:
		attack_left()


func attack_right() -> void:
	Sword.position = right_position
	sword_collision.disabled = false
	animated_sprite_2d.animation = "Visible"
	if Sword.rotation < deg_to_rad(140):
		Sword.rotation = Sword.rotation + deg_to_rad(2)

	if Sword.rotation > deg_to_rad(140):
		sword_collision.disabled = true
		animated_sprite_2d.animation = "Invisible"
		attacking_right = false
		attack_end.emit()



func attack_left() -> void:
	Sword.position = left_position
	sword_collision.disabled = false
	animated_sprite_2d.animation = "Visible"
	if Sword.rotation > deg_to_rad(220):
		Sword.rotation = Sword.rotation - deg_to_rad(0.5)

	if Sword.rotation < deg_to_rad(220) && Sword.rotation != 0:
		sword_collision.disabled = true
		animated_sprite_2d.animation = "Invisible"
		attacking_left = false
		attack_end.emit()





func _on_player_detection_attack_time_right() -> void:
	if (attacking_right == false):
		Sword.rotation = deg_to_rad(15)
		attacking_right = true



func _on_player_detection_attack_time_left() -> void:
	if (attacking_left == false):
		Sword.rotation = deg_to_rad(345)
		attacking_left= true


func _on_human_enemy_sword_freeze_sword() -> void:
	Sword.rotation = deg_to_rad(0)
	print("freezing brrr")
	await get_tree().create_timer(2)

