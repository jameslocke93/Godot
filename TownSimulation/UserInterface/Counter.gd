extends MarginContainer

export(Texture) var tTexture = load("res://Assets/GUI/bombs_icon.png")

onready var iIcon = $Background/Icon
onready var iNumber = $Background/Number


func _ready():
	iIcon.texture = tTexture


func set_number(sValue):
	iNumber.text = sValue
