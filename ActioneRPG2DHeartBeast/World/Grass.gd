extends Node2D


const GrassEffect = preload("res://Effects/GrassEffect.tscn")


func _on_Hurtbox_area_entered(area):
	if area.collision_mask == 8:
		create_grass_effect()
		queue_free()


func create_grass_effect():
	var grassEffect = GrassEffect.instance() # Creating instance of a scene generated above
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position # Sets grassEffect position as position of grass
