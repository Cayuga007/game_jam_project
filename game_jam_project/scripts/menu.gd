extends Control


@onready var play: Button = $Play


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.pressed.connect(func():
		get_tree().change_scene_to_file("res://scenes/game.tscn"))
