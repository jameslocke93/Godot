extends Node2D


var BuildButton = preload("res://UserInterface/BuildButton.tscn")
var BuildInterface = preload("res://UserInterface/BuildInterface.tscn")

onready var buildButton = BuildButton.instance()
onready var buildInterface = BuildInterface.instance()


func _ready():
	buildButton.set_position(Vector2(700, 600))


func add_button():
	add_child(buildButton)
