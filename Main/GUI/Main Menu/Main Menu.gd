extends Control

var boom_counter: int = 0

signal load_menu
signal option_menu

func open_game():
	get_tree().change_scene_to_file("res://Main/Loading/Loading.tscn")

func _on_start_pressed() -> void:
	open_game()


func _on_load_pressed() -> void:
	load_menu.emit()
	visible = false


func _on_options_pressed() -> void:
	option_menu.emit()
	visible = false


func _on_load_menu_back() -> void:
	visible = true


func _on_options_menu_back() -> void:
	visible = true

func _process(_delta):
	if boom_counter == 3:
		get_tree().change_scene_to_file("res://Main/GUI/Main Menu/Secret Ending.tscn")


func _on_menu_visualiser_boom() -> void:
	boom_counter = boom_counter + 1


func _on_menu_visualiser_2_boom() -> void:
	boom_counter = boom_counter + 1


func _on_menu_visualiser_3_boom() -> void:
	boom_counter = boom_counter + 1
