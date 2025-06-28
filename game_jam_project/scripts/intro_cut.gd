extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("Intro")
	await animated_sprite.animation_finished
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
