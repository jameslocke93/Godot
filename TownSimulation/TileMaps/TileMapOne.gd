extends Node2D


onready var base_map = $Land

export var gridWidth = 10
export var gridHeight = 10


func _ready():
	for x in range(gridWidth):
		for y in range(gridWidth):
			base_map.set_cell(x, y, gen_tile_type())


func gen_tile_type():
	var rand_float = randf()
	if rand_float < 0.8:
		return 0
	else:
		return 1


func get_tile(var position_vector):
	return base_map.get_cell(position_vector.x, position_vector.y)
