extends Node2D


onready var movementGrid = $MovementGrid

var player_grid_position = Vector2(0, 0) setget set_grid_position, get_grid_position


func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):	# Checks if left mouse butten is pressed
		var mouse_to_map_position = movementGrid.world_to_map(get_global_mouse_position())
		if check_world_tile(mouse_to_map_position):
			self.player_grid_position = mouse_to_map_position


func check_world_tile(destination):
	var world = get_tree().current_scene
	var world_map = world.find_node("Map")
	if world_map.get_tile(destination) >= 0:
		world.add_button()
		return true
	return false


func set_grid_position(value):
	player_grid_position = value
	position = movementGrid.map_to_world(value)


func get_grid_position():
	return player_grid_position
