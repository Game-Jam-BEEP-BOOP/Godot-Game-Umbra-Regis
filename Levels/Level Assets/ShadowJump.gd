extends Area2D
#author Ed
@export var jump_power : int = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass


func _on_body_entered(body : CharacterBody2D) -> void:
	body.velocity.y = -jump_power
	
