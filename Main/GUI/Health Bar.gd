extends ProgressBar

var projectile_damage: bool = false
var weapon_damage: bool = false
var damage: float
var heal : bool 
var healing : bool = false
var out_of_shadow: bool = false

signal ded

func _process(_delta):
	died()
	shadow_stuff()


func shadow_stuff():
	if out_of_shadow:
		Globals.currentHealth = clamp(Globals.currentHealth - 0.01, 0, Globals.maxHealth)
		value = Globals.currentHealth * 100 / Globals.maxHealth
		out_of_shadow = false
		return
	if not out_of_shadow:
		Globals.currentHealth = clamp(Globals.currentHealth + 0.01, 0, Globals.maxHealth)
		value = Globals.currentHealth * 100 / Globals.maxHealth
		return


func update():
	if Globals.currentHealth + damage < 1 && Globals.currentHealth < 0:
		#This is for healing
		Globals.currentHealth = clamp(Globals.currentHealth - damage, 0, Globals.maxHealth)
		
	elif (Globals.currentHealth + damage > 1 && damage < Globals.currentHealth):
		Globals.currentHealth = clamp(Globals.currentHealth - damage, 0, Globals.maxHealth)
	
	elif Globals.currentHealth == 1 and damage > 0:
		Globals.currentHealth = 0
	
	elif damage >= Globals.currentHealth && Globals.currentHealth > 0:
		Globals.currentHealth = 1
	
	elif damage < 0:
		pass
	value = Globals.currentHealth * 100 / Globals.maxHealth

func _on_gui_health_changed_gui(projectile, weapon,heal) -> void:
	if projectile:
		projectile_damage = true
	if weapon:
		weapon_damage = true
	if heal:
		healing = true
	determine_damage()

func died() -> void:
	if Globals.currentHealth < 1:
		
		Globals.currentHealth = Globals.maxHealth
		if Globals.currentShadow < Globals.maxShadow/4:
			Globals.currentShadow = Globals.maxShadow/4
		get_tree().paused = true
		ded.emit()

func determine_damage():
	if projectile_damage:
		damage = 15
		projectile_damage = false
	if weapon_damage:
		damage = 20
		weapon_damage = false
	if healing:
		damage = -60
		
	#for health boost make it a negative number
	update()


func _on_gui_out_of_shadow() -> void:
	out_of_shadow = true
