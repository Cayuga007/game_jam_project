class_name Obstacle extends Node2D


const REMOVE_DELAY = 0.3
const POP = preload("res://scenes/pop.tscn")
const GUST = preload("res://scenes/gust.tscn")

var particle_color: Color

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
var landed_on: bool = false

func remove_self() -> void:
	landed_on = true
	await get_tree().create_timer(0.2).timeout
	
	get_node("AnimatedSprite2D").visible = false
	get_node("CollisionShape2D").queue_free()
	
	var new_vfx
	if self is Balloon:
		new_vfx = POP.instantiate()
		new_vfx.color = particle_color
	else:
		new_vfx = GUST.instantiate()
	add_child(new_vfx)
	new_vfx.emitting = true
	await new_vfx.finished
	
	queue_free()
