extends Node

var wood: bool = false
var wood2: bool = false 
var wood3: bool = false 
var rock: bool = false
var rock2: bool = false
var rock3: bool = false
var metal_scraps: bool = false
var metal_scraps2: bool = false
var metal_scraps3: bool = false
var steel: bool = false
var steel2: bool = false
var steel3: bool = false
var ajuga: bool = false
var ajuga2: bool = false
var ajuga3: bool = false
var phantom_steel: bool = false
var phantom_steel2: bool = false
var phantom_steel3: bool = false
var brugmansia: bool = false
var brugmansia2: bool = false
var brugmansia3: bool = false
var hyssop: bool = false
var hyssop2: bool = false
var hyssop3: bool = false
var queen_of_the_night: bool = false
var queen_of_the_night2: bool = false
var queen_of_the_night3: bool = false
var item_created: bool = false

var count: int = 0

var wood_count: int = 0
var rock_count: int = 0
var metal_scraps_count: int = 0
var steel_count: int = 0
var ajuga_count: int = 0
var phantom_steel_count: int = 0
var brugmansia_count: int = 0
var hyssop_count: int = 0
var queen_of_the_night_count: int = 0

var free_space_1: bool = true
var free_space_2: bool = true
var free_space_3: bool = true
var start: bool = false


signal make_steel
signal make_phantom_steel
signal Potion_of_Humanity
signal Potion_of_Everlasting_Darkness
signal Potion_of_Good_Health
signal count1
signal count2
signal count3
signal trigger_reset
signal quit
signal begin


func _process(delta: float) -> void:
	if start:
		counting()
		mix_em_up_and_make_some_bubbly_bubbly_potions()
		cycle_through_1()
		cycle_through_2()
		cycle_through_3()
		no_item_created()


func counting():
	if count == 0:
		count1.emit()
	if count == 1:
		count2.emit()
	if count == 2:
		count3.emit()


func mix_em_up_and_make_some_bubbly_bubbly_potions():
	if count == 3:
		create_steel()
		create_phantom_steel()
		create_Potion_of_Good_Health()
		create_Potion_of_Humanity()
		create_Potion_of_Everlasting_Darkness()



func _on_alchemy_output_reset() -> void:
	item_created = false
	free_space_1 = true
	free_space_2 = true
	free_space_3 = true
	count = 0
	wood_count = 0
	rock_count = 0
	metal_scraps_count = 0
	steel_count = 0
	ajuga_count = 0
	phantom_steel_count = 0
	brugmansia_count = 0
	hyssop_count = 0
	queen_of_the_night_count = 0

func cycle_through_1() -> void:
	if not wood and not rock and not metal_scraps and not steel and not ajuga and not phantom_steel and not brugmansia and not hyssop and not queen_of_the_night:
		free_space_1 = true

func cycle_through_2() -> void:
	if not wood2 and not rock2 and not metal_scraps2 and not steel2 and not ajuga2 and not phantom_steel2 and not brugmansia2 and not hyssop2 and not queen_of_the_night2:
		free_space_2 = true

func cycle_through_3() -> void:
	if not wood3 and not rock3 and not metal_scraps3 and not steel3 and not ajuga3 and not phantom_steel3 and not brugmansia3 and not hyssop3 and not queen_of_the_night3:
		free_space_3 = true


func _on_wood_pressed() -> void:
	if not count == 3:
		if free_space_1:
			wood = true
			count = count + 1
			wood_count = wood_count + 1
		elif free_space_2:
			wood2 = true
			count = count + 1
			wood_count = wood_count + 1
		elif free_space_3:
			wood3 = true
			count = count + 1
			wood_count = wood_count + 1
		else:
			print("ingredient slots already full")


func _on_rock_pressed() -> void:
	if not count == 3:
		if free_space_1:
			rock = true
			count = count + 1
			rock_count = rock_count + 1
		elif free_space_2:
			rock2 = true
			count = count + 1
			rock_count = rock_count + 1
		elif free_space_3:
			rock3 = true
			count = count + 1
			rock_count = rock_count + 1
		else:
			print("ingredient slots already full")


func _on_metal_scraps_pressed() -> void:
	if not count == 3:
		if free_space_1:
			metal_scraps = true
			count = count + 1
			metal_scraps_count = metal_scraps_count + 1
		elif free_space_2:
			metal_scraps2 = true
			count = count + 1
			metal_scraps_count = metal_scraps_count + 1
		elif free_space_3:
			metal_scraps3 = true
			count = count + 1
			metal_scraps_count = metal_scraps_count + 1
		else:
			print("ingredient slots already full")


func _on_steel_pressed() -> void:
	if not count == 3:
		if free_space_1:
			steel = true
			count = count + 1
			steel_count = steel_count + 1
		elif free_space_2:
			steel2 = true
			count = count + 1
			steel_count = steel_count + 1
		elif free_space_3:
			steel3 = true
			count = count + 1
			steel_count = steel_count + 1
		else:
			print("ingredient slots already full")


func _on_ajuga_pressed() -> void:
	if not count == 3:
		if free_space_1:
			ajuga = true
			count = count + 1
			ajuga_count = ajuga_count + 1
		elif free_space_2:
			ajuga2 = true
			count = count + 1
			ajuga_count = ajuga_count + 1
		elif free_space_3:
			ajuga3 = true
			count = count + 1
			ajuga_count = ajuga_count + 1
		else:
			print("ingredient slots already full")

func _on_phantom_steel_pressed() -> void:
	if not count == 3:
		if free_space_1:
			phantom_steel = true
			count = count + 1
			phantom_steel_count = phantom_steel_count +1
		elif free_space_2:
			phantom_steel2 = true
			count = count + 1
			phantom_steel_count = phantom_steel_count +1
		elif free_space_3:
			phantom_steel3 = true
			count = count + 1
			phantom_steel_count = phantom_steel_count +1
		else:
			print("ingredient slots already full")


func _on_brugmansia_pressed() -> void:
	if not count == 3:
		if free_space_1:
			brugmansia = true
			count = count + 1
			brugmansia_count = brugmansia_count + 1
		elif free_space_2:
			brugmansia2 = true
			count = count + 1
			brugmansia_count = brugmansia_count + 1
		elif free_space_3:
			brugmansia3 = true
			count = count + 1
			brugmansia_count = brugmansia_count + 1
		else:
			print("ingredient slots already full")


func _on_hyssop_pressed() -> void:
	if not count == 3:
		if free_space_1:
			hyssop = true
			count = count + 1
			hyssop_count = hyssop_count + 1
		elif free_space_2:
			hyssop2 = true
			count = count + 1
			hyssop_count = hyssop_count + 1
		elif free_space_3:
			hyssop3 = true
			count = count + 1
			hyssop_count = hyssop_count + 1
		else:
			print("ingredient slots already full")


func _on_queen_of_the_night_pressed() -> void:
	if not count == 3:
		if free_space_1:
			queen_of_the_night = true
			count = count + 1
			queen_of_the_night_count = queen_of_the_night_count + 1
		elif free_space_2:
			queen_of_the_night2 = true
			count = count + 1
			queen_of_the_night_count = queen_of_the_night_count + 1
		elif free_space_3:
			queen_of_the_night3 = true
			count = count + 1
			queen_of_the_night_count = queen_of_the_night_count + 1
		else:
			print("ingredient slots already full")


func create_steel():
	if metal_scraps_count == 3:
		if Globals.stored_items.has("metal_scraps"):
			if Globals.stored_items["metal_scraps"] > 2:
				
				item_created = true
				make_steel.emit()
			else:
				await get_tree().create_timer(0.3).timeout
				trigger_reset.emit()
		else:
			await get_tree().create_timer(0.3).timeout
			trigger_reset.emit()


func create_phantom_steel():
	if steel_count == 1 and ajuga_count == 2:
		if Globals.stored_items.has("steel") and Globals.stored_items.has("ajuga"):
			if Globals.stored_items["steel"] > 0 and Globals.stored_items["ajuga"] > 1:
				item_created = true
				make_phantom_steel.emit()
			else:
				await get_tree().create_timer(0.3).timeout
				trigger_reset.emit()
		else:
			await get_tree().create_timer(0.3).timeout
			trigger_reset.emit()


func create_Potion_of_Good_Health():
	if phantom_steel_count == 1 and brugmansia_count == 2:
		if Globals.stored_items.has("phantom_steel") and Globals.stored_items.has("brugmansia"):
			if Globals.stored_items["phantom_steel"] > 0 and Globals.stored_items["brugmansia"] > 1:
				item_created = true
				Potion_of_Good_Health.emit()
			else:
				await get_tree().create_timer(0.3).timeout
				trigger_reset.emit()
		else:
			await get_tree().create_timer(0.3).timeout
			trigger_reset.emit()
		


func create_Potion_of_Humanity():
	if phantom_steel_count == 1 and hyssop_count == 2:
		if Globals.stored_items.has("phantom_steel") and Globals.stored_items.has("hyssop"):
			if Globals.stored_items["phantom_steel"] > 0 and Globals.stored_items["hyssop"] > 1:
				item_created = true
				Potion_of_Humanity.emit()
			else:
				await get_tree().create_timer(0.3).timeout
				trigger_reset.emit()
		else:
			await get_tree().create_timer(0.3).timeout
			trigger_reset.emit()
		


func create_Potion_of_Everlasting_Darkness():
	if phantom_steel_count == 1 and queen_of_the_night_count == 2:
		if Globals.stored_items.has("phantom_steel") and Globals.stored_items.has("queen_of_the_night"):
			if Globals.stored_items["phantom_steel"] > 0 and Globals.stored_items["queen_of_the_night"] > 1:
				item_created = true
				Potion_of_Everlasting_Darkness.emit()
			else:
				await get_tree().create_timer(0.3).timeout
				trigger_reset.emit()
		else:
			await get_tree().create_timer(0.3).timeout
			trigger_reset.emit()
		

func no_item_created():
	if count == 3 and not item_created:
		await get_tree().create_timer(0.3).timeout
		trigger_reset.emit()


func _on_alchemy_table_open_alchemy() -> void:
	start = true
	get_tree().paused = true
	begin.emit()
