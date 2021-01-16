extends Control


onready var world = self.get_parent()


func _on_Button_pressed():
	world.iPopulation += 1
