extends HBoxContainer


onready var iPopulation = $TownMetrics/Population
onready var iFood = $Resources/Food
onready var iWood = $Resources/Wood
onready var iGold = $Resources/Gold


func get_pop():
	return iPopulation


func get_food():
	return iFood


func get_wood():
	return iWood


func get_gold():
	return iGold
