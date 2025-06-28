class_name Obstacle extends Node2D


const REMOVE_DELAY = 0.3
const POP = preload("res://scenes/pop.tscn")

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
var landed_on: bool = false

func remove_self() -> void:
	landed_on = true
	await get_tree().create_timer(0.2).timeout
	
	get_node("AnimatedSprite2D").visible = false
	get_node("CollisionShape2D").queue_free()
	
	var new_pop = POP.instantiate()
	add_child(new_pop)
	new_pop.emitting = true
	
	await new_pop.finished
	
	queue_free()
