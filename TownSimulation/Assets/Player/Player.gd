extends KinematicBody2D


onready var movementGrid = $MovementGrid


func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):	# Checks if left mouse butten is pressed
		var mouse_to_map_position = movementGrid.world_to_map(get_global_mouse_position())
		var destination = movementGrid.map_to_world(mouse_to_map_position)
		position = destination
		check_world_tile(mouse_to_map_position)


func check_world_tile(destination):
	var world = get_tree().current_scene
	var world_map = world.find_node("Map")
	print(world_map.get_tile(destination))
