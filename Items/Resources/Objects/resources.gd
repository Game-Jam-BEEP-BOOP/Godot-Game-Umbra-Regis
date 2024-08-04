extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D


var not_broken: String
var broken: String
var current_location: int
var current_item: String
var correct_resource: bool = false
var mouse_clickable: bool = false


var spawn_locations = {
#		0: Vector2(1838, 556),
#		1: Vector2(-1418, 755),
#		2: Vector2(-2134, 146),
#		3: Vector2(-2645, 731)
		}


var item = {
#		0: "wood",
#		1: "rock",
#		2: "metal_scraps",
#		3: "ajuga",
#		4: "brugmansia",
#		5: "hyssop",
#		6: "queen_of_the_night"
		}


func start() -> void:
	signal_setup()
	item_picker()
	positioner()
	set_collision_layer_value(6, true)
	visible = true
	default_animation()


func signal_setup() -> void:
	var mc = get_parent().get_parent().get_node("Main Character")
	var _self = $"."
	
	mc.connect("resource_break", resource_break)
	mc.connect("resource_pick_up", pick_up)
	_self.connect("mouse_entered", mouse_entered)
	_self.connect("mouse_exited", mouse_exited)


func mouse_entered() -> void:
	mouse_clickable = true


func mouse_exited() -> void:
	mouse_clickable = false


func positioner() -> void:
	position = spawn_locations[current_location]


func default_animation() -> void:
	animated_sprite_2d.animation = not_broken


# breaking
func resource_break() -> void:
	if mouse_clickable:
		correct_resource = true
		animated_sprite_2d.animation = broken


func pick_up() -> void:
	if correct_resource:
		correct_resource = false
		set_collision_layer_value(6, false)
		await get_tree().create_timer(0.1).timeout
		animated_sprite_2d.animation = "pickup"
		if Globals.stored_items.has(current_item):
			Globals.stored_items[current_item] += 1
		else:
			Globals.stored_items[current_item] = 1



func item_picker() -> void:
	var chosen_number: int = randi() % item.size()
	current_item = item[chosen_number]
	call(current_item)


func wood() -> void:
	not_broken = "wood"
	broken = "broken_wood"

func rock() -> void:
	not_broken = "rock"
	broken = "broken_rock"

func metal_scraps() -> void:
	not_broken = "metal_scraps"
	broken = "broken_metal_scraps" 

func ajuga() -> void:
	not_broken = "ajuga"
	broken = "broken_ajuga"

func brugmansia() -> void:
	not_broken = "brugmansia"
	broken = "broken_brugmansia"

func hyssop() -> void:
	not_broken = "hyssop"
	broken = "broken_hyssop"

func queen_of_the_night() -> void:
	not_broken = "queen_of_the_night"
	broken = "broken_queen_of_the_night"



#to add a new item, make a new function with its name, info and animations 
#and it to the dictionary with the next available number
