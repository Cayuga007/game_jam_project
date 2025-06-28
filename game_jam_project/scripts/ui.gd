extends CanvasLayer


@onready var game_over_screen: PanelContainer = $GameOverScreen
@onready var score_label: Label = $GameOverScreen/VBoxContainer/Score
@onready var replay: Button = $GameOverScreen/VBoxContainer/HBoxContainer/Replay
@onready var quit: Button = $GameOverScreen/VBoxContainer/HBoxContainer/Quit


func _ready() -> void:
	game_over_screen.visible = false
	replay.pressed.connect(func():
		get_tree().reload_current_scene())
	quit.pressed.connect(func():
		get_tree().change_scene_to_file("res://scenes/menu.tscn"))
	

func update_score(score: int) -> void:
	game_over_screen.visible = true
	score_label.text = str(score) + "m"
