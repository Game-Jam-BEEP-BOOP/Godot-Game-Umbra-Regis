extends Node

@export var resources: PackedScene = preload("res://Items/Resources/Objects/resources.tscn")
var new_resource: Node2D
var spawn_locations: Array

func _ready() -> void:
	var temp_resource = resources.instantiate()
	spawn_locations = temp_resource.spawn_locations.keys()
	temp_resource.queue_free()
	spawn_locations.shuffle()
	
	instantiate()

func instantiate() -> void:
	for i in spawn_locations:
		new_resource = resources.instantiate()
		add_child(new_resource)
		new_resource.signal_setup()
		new_resource.current_location = spawn_locations[i]
		new_resource.set_collision_layer_value(6, true)
		new_resource.start()
	
