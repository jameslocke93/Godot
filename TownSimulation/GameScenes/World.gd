extends Node2D


var BuildButton = preload("res://UserInterface/BuildButton.tscn")
var BuildInterface = preload("res://UserInterface/BuildInterface.tscn")
var BuildMenu = preload("res://UserInterface/BuildMenu.tscn")

onready var buildButton = BuildButton.instance()
onready var buildInterface = BuildInterface.instance()

onready var iBuildingHUD = $BuildingHUD
onready var iBuildingLayer = $Map/BuildingLayer
onready var iLandLayer = $Map/Land
onready var iPlayer = $Player

onready var start_time = OS.get_ticks_msec()
onready var offset_time = start_time

export(int) var nExpPopulation = 0
export(int) var nExpFood = 0
export(int) var nExpWood = 0
export(int) var nExpGold = 0
export(int) var nTimeStep = 15

var iPopulation setget set_pop, get_pop
var iFood setget set_food, get_food
var iWood setget set_wood, get_wood
var iGold setget set_gold, get_gold

var buildMenu
var aTownBuildingsProduction = []
var aTownBuildingsUpkeep = []
var timesteps = 0

func _ready():
	buildButton.set_position(Vector2(700, 600))
	
	self.iPopulation = nExpPopulation
	self.iFood = nExpFood
	self.iWood = nExpWood
	self.iGold = nExpGold
	self.nTimeStep = nTimeStep * 1000


func _process(delta):
	# Every x amount of time (in seconds) let's progress timestep
	if OS.get_ticks_msec() - offset_time >= nTimeStep:
		timesteps += 1
		print("Elapsed time: ", (OS.get_ticks_msec() - start_time) / 1000, " Timesteps: ", timesteps)
		self.offset_time = OS.get_ticks_msec()
		
		# Order matters, want production prior to upkeep to stop player going into negative incorrectly
		town_production()
		town_upkeep()


func town_upkeep():
	var total_upkeep = [0, 0, 0]
	
	for building in aTownBuildingsUpkeep:
		for i in range(len(total_upkeep)):
			total_upkeep[i] += building[i]
	
	self.iFood -= total_upkeep[0]
	self.iWood -= total_upkeep[1]
	self.iGold -= total_upkeep[2]


func town_production():
	var total_production = [0, 0, 0]
	
	for building in aTownBuildingsProduction:
		for i in range(len(total_production)):
			total_production[i] += building[i]
	
	self.iFood += total_production[0]
	self.iWood += total_production[1]
	self.iGold += total_production[2]


func add_button():
	# Finding if build button exists as find_node doesn't seem to be working as intended
	var button_exists = false
	for child in get_children():
		if child.get_name() == "BuildButton":
			button_exists = true

	if !button_exists:
		add_child(buildButton)
		buildButton.connect("pressed", self, "_on_build_pressed")


func _on_build_pressed():
	buildMenu = BuildMenu.instance()
	buildMenu.set_position(Vector2(700, 100))
	add_child(buildMenu)
	
	for build_option in buildMenu.get_children():
		build_option.connect("option_chosen", self, "_on_option_chosen")


func get_player_tile():
	return iLandLayer.get_cellv(iPlayer.get_grid_position())


func _on_option_chosen(cost, production, upkeep, tile_type):
	if iFood >= cost[0] and iWood >= cost[1] and iGold >= cost[2]:
		var player_pos = iPlayer.get_grid_position()
		
		# Subtract resources, place tile, remove menu
		self.iFood -= cost[0]
		self.iWood -= cost[1]
		self.iGold -= cost[2]
		
		# Add new tile data to town building array
		aTownBuildingsProduction.append(production)
		aTownBuildingsUpkeep.append(upkeep)
		
		# Need to set set cell to returned tile type
		iBuildingLayer.set_cell(player_pos.x, player_pos.y, tile_type)
		
		buildMenu.queue_free()


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
