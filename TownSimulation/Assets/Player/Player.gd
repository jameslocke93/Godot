extends Node2D


onready var movementGrid = $MovementGrid
onready var buildButton = $MovementGrid/BuildButton


func _ready():
	buildButton.rect_position = Vector2(700, 600)
	buildButton.visible = false


func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):	# Checks if left mouse butten is pressed
		var mouse_to_map_position = movementGrid.world_to_map(get_global_mouse_position())
		if check_world_tile(mouse_to_map_position):
			position = movementGrid.map_to_world(mouse_to_map_position)


func check_world_tile(destination):
	var world = get_tree().current_scene
	var world_map = world.find_node("Map")
	if world_map.get_tile(destination) >= 0:
		buildButton.visible = true
		return true
	return false
	
