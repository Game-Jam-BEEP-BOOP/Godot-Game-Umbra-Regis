extends Panel
@onready var animated_sprite_2d: AnimatedSprite2D = $Area2D/AnimatedSprite2D

var wood: bool = false
var rock: bool = false
var metal_scraps: bool = false
var steel: bool = false
var ajuga: bool = false
var phantom_steel: bool = false
var brugmansia: bool = false
var hyssop: bool = false
var queen_of_the_night: bool = false
var count: bool = false
var show_up: bool = false



func _on_wood_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "wood"
		count = false

func _on_rock_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "rock"
		count = false

func _on_metal_scraps_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "metal_scraps"
		count = false

func _on_steel_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "steel"
		count = false

func _on_ajuga_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "ajuga"
		count = false

func _on_phantom_steel_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "phantom_steel"
		count = false

func _on_brugmansia_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "brugmansia"
		count = false

func _on_hyssop_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "hyssop"
		count = false

func _on_queen_of_the_night_pressed() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night and count:
		animated_sprite_2d.animation = "queen_of_the_night"
		count = false



func _on_alchemy_output_reset() -> void:
	animated_sprite_2d.animation = "no pick"


func _on_alchemy_screen_count_1() -> void:
	count = true

