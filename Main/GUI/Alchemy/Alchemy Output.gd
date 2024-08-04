extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var clickable: bool = false
var output: bool = false
var creation: String

signal reset


func _process(_delta) -> void:
	pick_up()


func _on_alchemy_screen_make_steel() -> void:
	animated_sprite_2d.animation = "steel"
	output = true
	creation = "steel"


func _on_alchemy_screen_make_phantom_steel() -> void:
	animated_sprite_2d.animation = "phantom_steel"
	output = true
	creation = "phantom_steel"

func _on_alchemy_screen_potion_of_everlasting_darkness() -> void:
	animated_sprite_2d.animation = "potion_of_everlasting_darkness"
	output = true
	creation = "Potion_of_Everlasting_Darkness"

func _on_alchemy_screen_potion_of_good_health() -> void:
	animated_sprite_2d.animation = "potion_of_good_health"
	output = true
	creation = "Potion_of_Good_Health"

func _on_alchemy_screen_potion_of_humanity() -> void:
	animated_sprite_2d.animation = "potion_of_humanity"
	output = true
	creation = "Potion_of_Humanity"




func pick_up():
	if Input.is_action_just_pressed("Attack") and clickable and output:
		animated_sprite_2d.animation = "no output"
		output = false
		if Globals.stored_items.has(creation):
			Globals.stored_items[creation] += 1
		else:
			Globals.stored_items[creation] = 1
		remove_ingredients()
		reset.emit()


func remove_ingredients():
	if creation == "steel":
		Globals.stored_items["metal_scraps"] -= 3
	
	if creation == "phantom_steel":
		Globals.stored_items["steel"] -= 1
		Globals.stored_items["ajuga"] -= 2
	
	if creation == "Potion_of_Good_Health":
		Globals.stored_items["phantom_steel"] -= 1
		Globals.stored_items["brugmansia"] -= 2
	
	if creation == "Potion_of_Humanity":
		Globals.stored_items["phantom_steel"] -= 1
		Globals.stored_items["hyssop"] -= 2
	
	if creation == "Potion_of_Everlasting_Darkness":
		Globals.stored_items["phantom_steel"] -= 1
		Globals.stored_items["queen_of_the_night"] -= 2
	


func _on_mouse_entered() -> void:
	clickable = true

func _on_mouse_exited() -> void:
	clickable = false


func _on_alchemy_screen_trigger_reset() -> void:
	reset.emit()
