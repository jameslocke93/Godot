extends MarginContainer


var mouse_entered = false

var food_cost setget set_food_cost
var wood_cost setget set_wood_cost
var gold_cost setget set_gold_cost

var food_upkeep setget set_food_upkeep
var wood_upkeep setget set_wood_upkeep
var gold_upkeep setget set_gold_upkeep

var food_production setget set_food_production
var wood_production setget set_wood_production
var gold_production setget set_gold_production

var tile_type
var resource_cost
var resource_upkeep
var resource_production
var build_icon

signal option_chosen


func init(build, modifier):
	# Has to be declered here as onready and _ready weren't functioning as expected
	resource_cost = $Rows/TopBars/ResourceCost
	resource_upkeep = $Rows/BottomBars/ResourceUpkeep
	resource_production = $Rows/BottomBars/ResourceProduction
	build_icon = $Rows/TopBars/Icon
	
	self.food_cost = build["cost"]["food"]* modifier["cost"]["food"]
	self.wood_cost = build["cost"]["wood"]* modifier["cost"]["wood"]
	self.gold_cost = build["cost"]["gold"]* modifier["cost"]["gold"]
	
	self.food_production = build["production"]["food"]* modifier["production"]["food"]
	self.wood_production = build["production"]["wood"]* modifier["production"]["wood"]
	self.gold_production = build["production"]["gold"]* modifier["production"]["gold"]
	
	self.food_upkeep = build["upkeep"]["food"]* modifier["upkeep"]["food"]
	self.wood_upkeep = build["upkeep"]["wood"]* modifier["upkeep"]["wood"]
	self.gold_upkeep = build["upkeep"]["gold"]* modifier["upkeep"]["gold"]
	
	self.tile_type = build["ID"]
	self.build_icon.texture = load(build["icon"])
	connect("mouse_entered", self, "_on_BuildOption_mouse_entered")
	connect("mouse_exited", self, "_on_BuildOption_mouse_exited")


func _process(delta):
	if mouse_entered and Input.is_mouse_button_pressed(1):
		emit_signal("option_chosen", [food_cost, wood_cost, gold_cost], [food_production, wood_production, gold_production], [food_upkeep, wood_upkeep, gold_upkeep], self.tile_type)


func _on_BuildOption_mouse_entered():
	mouse_entered = true


func _on_BuildOption_mouse_exited():
	mouse_entered = false


func set_food_cost(value):
	food_cost = value
	resource_cost.find_node("Food").text = "Food: " + String(value)


func set_wood_cost(value):
	wood_cost = value
	resource_cost.find_node("Wood").text = "Wood: " + String(value)


func set_gold_cost(value):
	gold_cost = value
	resource_cost.find_node("Gold").text = "Gold: " + String(value)


func set_food_upkeep(value):
	food_upkeep = value
	resource_upkeep.find_node("Food").text = "Food: " + String(value)


func set_wood_upkeep(value):
	wood_upkeep = value
	resource_upkeep.find_node("Wood").text = "Wood: " + String(value)


func set_gold_upkeep(value):
	gold_upkeep = value
	resource_upkeep.find_node("Gold").text = "Gold: " + String(value)


func set_food_production(value):
	food_production = value
	resource_production.find_node("Food").text = "Food: " + String(value)


func set_wood_production(value):
	wood_production = value
	resource_production.find_node("Wood").text = "Food: " + String(value)


func set_gold_production(value):
	gold_production = value
	resource_production.find_node("Gold").text = "Food: " + String(value)
