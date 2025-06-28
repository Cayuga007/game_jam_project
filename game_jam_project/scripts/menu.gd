extends Control


@onready var play: Button = $Play
@onready var quit: Button = $Quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuMusic.play()
	GameplayMusic.playing = false
	play.pressed.connect(func():
		MenuMusic.playing = false
		get_tree().change_scene_to_file("res://scenes/game.tscn"))
	quit.pressed.connect(func():
		get_tree().quit())
