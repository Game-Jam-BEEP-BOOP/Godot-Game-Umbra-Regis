extends Control


signal back


func _ready() -> void:
	visible = false


func _on_main_menu_option_menu() -> void:
	visible = true


func _on_back_button_pressed() -> void:
	visible = false
	back.emit()
