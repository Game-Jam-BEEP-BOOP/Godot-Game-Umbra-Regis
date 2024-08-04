extends Button
const SAVE_GAME_PATH : String = "user://save.json"
const CURRENT_SCENE_PATH : String = "user://currentscene.tscn"
@onready var current_scene = ResourceLoader.load(CURRENT_SCENE_PATH)

func load_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		var currentHealth = file.get_var()
		var deaths = file.get_var()
		var slotAssignment = file.get_var()
		var currentShadow = file.get_var()
		var player_position = file.get_var()
		print(str(currentHealth) + " currentHealth")
		Globals.currentHealth = currentHealth
		Globals.deaths = deaths
		Globals.slot_assignment = slotAssignment
		Globals.currentShadow = currentShadow
		var current_scene_instance = current_scene.instantiate()
		get_tree().root.add_child(current_scene_instance)
		get_tree().current_scene = current_scene_instance
		get_tree().current_scene.get_node("Main Character").global_position = player_position

	else:
		print("no data")
		Globals.currentHealth = 0 
		Globals.currentShadow = 0 
		Globals.slot_assignment = {
		"slot1": false,
		"slot2": false,
		"slot3": false,
		"slot4": false,
		"slot5": false,
		"slot6": false,
		"slot7": false,
		"slot8": false,
		"slot9": false,
		"slot10": false,
		"slot11": false,
		"slot12": false,
		"slot13": false,
		"slot14": false,
		"slot15": false,
		"slot16": false,
		"slot17": false,
		"slot18": false
		}


func _on_pressed() -> void:
	load_data()
