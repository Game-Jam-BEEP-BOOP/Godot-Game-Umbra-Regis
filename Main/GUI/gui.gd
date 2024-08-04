extends Control

signal healthChangedGUI
signal shadowChangedGUI
signal shadow_bar_empty
signal out_of_shadow
signal slot1_item
signal slot2_item
signal slot3_item
signal player_dead


var drain_amount: float = 0.0
var idle_fly_drain: float = 0.05
var slow_fly_drain: float = 0.2
var fast_fly_drain: float = 0.3
var gremlin_drain: float = 0.1
var dagger_drain: float = 5
var fade_drain: float = 0.1
var inshadow_gain: float = 0.2
var reset: float = 0.0



func _on_main_character_health_changed(projectile, weapon , heal) -> void:
	healthChangedGUI.emit(projectile, weapon,heal)




#shadow bar has been used mmhm yes
func _on_main_character_idlefly() -> void:
	drain_amount -= idle_fly_drain
func _on_main_character_slowfly() -> void:
	drain_amount -= slow_fly_drain
func _on_main_character_fastfly() -> void:
	drain_amount -= fast_fly_drain
func _on_main_character_gremlinchange() -> void:
	drain_amount -= gremlin_drain
func _on_main_character_daggerchange() -> void:
	drain_amount -= dagger_drain
func _on_main_character_fadechange() -> void:
	drain_amount -= fade_drain
func _on_main_character_inshadowchange() -> void:
	drain_amount = inshadow_gain
func _on_main_character_nuh_uh() -> void:
	drain_amount = reset


func _process(_delta):
	shadowChangedGUI.emit(drain_amount)
	drain_amount = 0


func _on_shadow_bar_bar_empty() -> void:
	shadow_bar_empty.emit()


func _on_hotbar_slot_1_guh(slot1) -> void:
	slot1_item.emit(slot1)


func _on_hotbar_slot_2_guh(slot2) -> void:
	slot2_item.emit(slot2)


func _on_hotbar_slot_3_guh(slot3) -> void:
	slot3_item.emit(slot3)


func _on_main_character_shadow_damage() -> void:
	out_of_shadow.emit()
