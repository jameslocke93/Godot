extends Node2D


onready var movementGrid = $MovementGrid

var player_grid_position = Vector2(0, 0) setget set_grid_position, get_grid_position


func _process(delta):
	if Input.is_mouse_button_pressed(1):	# Checks if left mouse butten is pressed
		var mouse_to_map_position = movementGrid.world_to_map(get_global_mouse_position())
		if check_world_tile(mouse_to_map_position):
			self.player_grid_position = mouse_to_map_position


# TODO: Can change this function to interact with get_player_tile in world
func check_world_tile(destination):
	var world = get_tree().current_scene
	var world_map = world.find_node("Map")
	if world_map.get_tile(destination) >= 0:
		# Need to add some functionality to see if button already exists
		world.add_button()
		return true
	return false


func set_grid_position(value):
	# Remove old player indicator
	movementGrid.set_cellv(player_grid_position, -1)
	# Set new player indicator
	player_grid_position = value
	movementGrid.set_cellv(value, 0)


func get_grid_position():
	return player_grid_position
