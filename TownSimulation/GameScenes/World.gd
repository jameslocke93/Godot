extends Node2D


var BuildButton = preload("res://UserInterface/BuildButton.tscn")
var BuildInterface = preload("res://UserInterface/BuildInterface.tscn")

onready var buildButton = BuildButton.instance()
onready var buildInterface = BuildInterface.instance()
onready var iBuildingHUD = $BuildingHUD

export(int) var iExpPopulation = 0
export(int) var iExpFood = 0
export(int) var iExpWood = 0
export(int) var iExpGold = 0

var iPopulation setget set_pop, get_pop
var iFood setget set_food, get_food
var iWood setget set_wood, get_wood
var iGold setget set_gold, get_gold


func _ready():
	buildButton.set_position(Vector2(700, 600))
	
	self.iPopulation = iExpPopulation
	self.iFood = iExpFood
	self.iWood = iExpWood
	self.iGold = iExpGold


func _process(delta):
	pass

 
func add_button():
	add_child(buildButton)


func set_pop(value):
	iPopulation = value
	iBuildingHUD.get_pop().set_number(String(iPopulation))


func get_pop():
	return iPopulation


func set_food(value):
	iFood = value
	iBuildingHUD.get_food().set_number(String(iFood))


func get_food():
	return iFood


func set_wood(value):
	iWood = value
	iBuildingHUD.get_wood().set_number(String(iWood))


func get_wood():
	return iWood


func set_gold(value):
	iGold = value
	iBuildingHUD.get_gold().set_number(String(iGold))


func get_gold():
	return iGold
