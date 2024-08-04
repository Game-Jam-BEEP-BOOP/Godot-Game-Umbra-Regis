extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var item_amount_digit_1: AnimatedSprite2D = $"item amount digit 1"
@onready var item_amount_digit_2: AnimatedSprite2D = $"item amount digit 2"
@onready var item_amount_digit_3: AnimatedSprite2D = $"item amount digit 3"


var item: String
var current_slot: Vector2 = Vector2(30, 24)
var started: bool = false
var clickable: bool = false
var dragging: bool = false
var open: bool = false
var slots_full: bool = false
var count: int
var count_string: String
var digits = []
var digit_size: int
var digit: String


func start() -> void:
	animated_sprite_2d.animation = item
	started = true
	item_amount_digit_1.animation = "NIL"
	item_amount_digit_2.animation = "NIL"
	item_amount_digit_3.animation = "NIL"


func _process(_delta) -> void:
	if started:
		open_close_inventory()
		item_counter()


func signal_setup() -> void:
	var slot1 = $"../Slot"
	var slot2 = $"../Slot2"
	var slot3 = $"../Slot2"
	var slot4 = $"../Slot4"
	var slot5 = $"../Slot5"
	var slot6 = $"../Slot6"
	var slot7 = $"../Slot7"
	var slot8 = $"../Slot8"
	var slot9 = $"../Slot9"
	var slot10 = $"../Slot10"
	var slot11 = $"../Slot11"
	var slot12 = $"../Slot12"
	var slot13 = $"../Slot13"
	var slot14 = $"../Slot14"
	var slot15 = $"../Slot15"
	var slot16 = $"../Slot16"
	var slot17 = $"../Slot17"
	var slot18 = $"../Slot18"
	
	slot1.connect("mouse_enter_slot", slot_1)
	slot2.connect("mouse_enter_slot", slot_2)
	slot3.connect("mouse_enter_slot", slot_3)
	slot4.connect("mouse_enter_slot", slot_4)
	slot5.connect("mouse_enter_slot", slot_5)
	slot6.connect("mouse_enter_slot", slot_6)
	slot7.connect("mouse_enter_slot", slot_7)
	slot8.connect("mouse_enter_slot", slot_8)
	slot9.connect("mouse_enter_slot", slot_9)
	slot10.connect("mouse_enter_slot", slot_10)
	slot11.connect("mouse_enter_slot", slot_11)
	slot12.connect("mouse_enter_slot", slot_12)
	slot13.connect("mouse_enter_slot", slot_13)
	slot14.connect("mouse_enter_slot", slot_14)
	slot15.connect("mouse_enter_slot", slot_15)
	slot16.connect("mouse_enter_slot", slot_16)
	slot17.connect("mouse_enter_slot", slot_17)
	slot18.connect("mouse_enter_slot", slot_18)


func open_close_inventory() -> void:
	if Input.is_action_just_pressed("toggle_inventory") and not open:
		open = true
		visible = true
		return
	if Input.is_action_just_pressed("toggle_inventory") and open:
		open = false
		visible = false
		return


func item_counter():
	count = Globals.stored_items[item]
	count_string = str(count)
	digits.clear()
	for char in count_string:
		digits.append(int(char))
	digit_size = digits.size()
	
	if digit_size == 3:
		item_amount_digit_1.animation = str(digits[0])
		item_amount_digit_2.animation = str(digits[1])
		item_amount_digit_3.animation = str(digits[2])
		
	if digit_size == 2:
		item_amount_digit_2.animation = str(digits[0])
		item_amount_digit_3.animation = str(digits[1])
	
	if digit_size == 1:
		item_amount_digit_3.animation = str(digits[0])


func slot_picker():
	slot_1()
	position = current_slot


func slot_1():
	if slots_full:
		print("uh oh")
	if Globals.slot_assignment["slot1"] == false: 
		current_slot = Vector2(30, 24)
		Globals.slot_assignment["slot1"] = true
	elif not slots_full:
		dragging = false
		slot_2()
		

func slot_2():
	if Globals.slot_assignment["slot2"] == false: 
		current_slot = Vector2(94, 24)
		Globals.slot_assignment["slot2"] = true
	else:
		dragging = false
		slot_3()

func slot_3():
	if Globals.slot_assignment["slot3"] == false: 
		current_slot = Vector2(158, 24)
		Globals.slot_assignment["slot3"] = true
	else:
		dragging = false
		slot_4()

func slot_4():
	if Globals.slot_assignment["slot4"]== false: 
		current_slot = Vector2(222, 24)
		Globals.slot_assignment["slot4"] = true
	else:
		dragging = false
		slot_5()

func slot_5():
	if Globals.slot_assignment["slot5"] == false:  
		current_slot = Vector2(286, 24)
		Globals.slot_assignment["slot5"] = true
	else:
		dragging = false
		slot_6()

func slot_6():
	if Globals.slot_assignment["slot6"] == false:  
		current_slot = Vector2(350, 24)
		Globals.slot_assignment["slot6"] = true
	else:
		dragging = false
		slot_7()

func slot_7():
	if Globals.slot_assignment["slot7"] == false: 
		current_slot = Vector2(30, 78)
		Globals.slot_assignment["slot7"] = true
	else:
		dragging = false
		slot_8()

func slot_8():
	if Globals.slot_assignment["slot8"] == false: 
		current_slot = Vector2(94, 78)
		Globals.slot_assignment["slot8"] = true
	else:
		dragging = false
		slot_9()

func slot_9():
	if Globals.slot_assignment["slot9"] == false:  
		current_slot = Vector2(158, 78)
		Globals.slot_assignment["slot9"] = true
	else:
		dragging = false
		slot_10()

func slot_10():
	if Globals.slot_assignment["slot10"] == false: 
		current_slot = Vector2(222, 78)
		Globals.slot_assignment["slot10"] = true
	else:
		dragging = false
		slot_11()

func slot_11():
	if Globals.slot_assignment["slot11"] == false: 
		current_slot = Vector2(286, 78)
		Globals.slot_assignment["slot11"] = true
	else:
		dragging = false
		slot_12()

func slot_12():
	if Globals.slot_assignment["slot12"] == false: 
		current_slot = Vector2(350, 78)
		Globals.slot_assignment["slot12"] = true
	else:
		dragging = false
		slot_13()

func slot_13():
	if Globals.slot_assignment["slot13"] == false: 
		current_slot = Vector2(30, 132)
		Globals.slot_assignment["slot13"] = true
	else:
		dragging = false
		slot_14()

func slot_14():
	if Globals.slot_assignment["slot14"] == false: 
		current_slot = Vector2(94, 132)
		Globals.slot_assignment["slot14"] = true
	else:
		dragging = false
		slot_15()

func slot_15():
	if Globals.slot_assignment["slot15"] == false: 
		current_slot = Vector2(158, 132)
		Globals.slot_assignment["slot15"] = true
	else:
		dragging = false
		slot_16()

func slot_16():
	if Globals.slot_assignment["slot16"] == false: 
		current_slot = Vector2(222, 132)
		Globals.slot_assignment["slot16"] = true
	else:
		dragging = false
		slot_17()

func slot_17():
	if Globals.slot_assignment["slot17"] == false: 
		current_slot = Vector2(286, 132)
		Globals.slot_assignment["slot17"] = true
	else:
		dragging = false
		slot_18()

func slot_18():
	if Globals.slot_assignment["slot18"] == false:
		current_slot = Vector2(350,132)
		Globals.slot_assignment["slot18"] = true
	else:
		dragging = false
		slots_full = true
		slot_1()

func wood() -> void:
	item = "wood"

func rock() -> void:
	item = "rock"

func metal_scraps() -> void:
	item = "metal_scraps"

func steel() -> void:
	item = "steel"

func ajuga() -> void:
	item = "ajuga"

func phantom_steel() -> void:
	item = "phantom_steel"

func brugmansia() -> void:
	item = "brugmansia"

func hyssop() -> void:
	item = "hyssop"

func queen_of_the_night() -> void:
	item = "queen_of_the_night"

func Potion_of_Good_Health() -> void:
	item = "Potion_of_Good_Health"

func Potion_of_Humanity() -> void:
	item = "Potion_of_Humanity"

func Potion_of_Everlasting_Darkness() -> void:
	item = "Potion_of_Everlasting_Darkness"
