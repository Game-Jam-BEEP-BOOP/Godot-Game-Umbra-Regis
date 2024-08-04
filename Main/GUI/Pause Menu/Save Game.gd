extends Button

const SAVE_GAME_PATH : String = "user://save.json"
const CURRENT_SCENE_PATH : String = "user://currentscene.tscn"


var version = 1




func save():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)#Gives us access 
	file.store_var(Globals.currentHealth)
	file.store_var(Globals.deaths)
	file.store_var(Globals.slot_assignment)
	file.store_var(Globals.currentShadow)
	file.store_var(get_tree().current_scene.get_node("Main Character").global_position)
	#saving current scene
	var scene : PackedScene = PackedScene.new()
	scene.pack(get_tree().current_scene)
	
	var currentSceneFile = ResourceSaver.save(scene,CURRENT_SCENE_PATH)
	
		


func _on_pressed() -> void:
	save()
