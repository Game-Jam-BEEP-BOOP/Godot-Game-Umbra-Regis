extends Panel

func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	slot_selector()


func slot_selector() -> void:
	if Input.is_action_just_pressed("hotbar 1"):
		visible = true
		position = Vector2(-88,15)
	if Input.is_action_just_pressed("hotbar 2"):
		visible = true
		position = Vector2(-38,15)
	if Input.is_action_just_pressed("hotbar 3"):
		visible = true
		position = Vector2(13,15)
