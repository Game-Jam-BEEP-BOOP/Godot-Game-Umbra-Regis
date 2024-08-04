extends ProgressBar

var projectile_damage: bool = false
var weapon_damage: bool = false
var damage: float

signal player_dead

func _process(_delta):
	died()

func update():
	if Globals.currentHealth + damage > 1:
		print("update 1")
		Globals.currentHealth = clamp(Globals.currentHealth + damage, 0, Globals.maxHealth)
	elif Globals.currentHealth == 1 and damage > 0:
		print("update 2")
		Globals.currentHealth = 0
	elif damage > 0:
		print("update 3")
		Globals.currentHealth = 1
	elif damage < 0:
		print("update 4")
		pass
	value = Globals.currentHealth * 100 / Globals.maxHealth

func _on_gui_health_changed_gui(projectile, weapon) -> void:
	print(str(projectile)  + " Projectile boolean")
	print(str(weapon) + " Weapon Boolean")
	if projectile:
		projectile_damage = true
	elif weapon:
		weapon_damage = true
	determine_damage()

func died() -> void:
	if Globals.currentHealth == 0:
		print("die time")
		player_dead.emit()

func determine_damage():
	if projectile_damage:
		print("determien projectile")
		damage -= 15
		print("projectile damage set")
		projectile_damage = false
		print(str(Globals.currentHealth) + " Current Health")
	elif weapon_damage:
		print("determined weapon")
		print(str(Globals.currentHealth) + " Current Health")
		damage -= 20
		print("weapon damage set")
		weapon_damage = false
	update()
