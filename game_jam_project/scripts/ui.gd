extends CanvasLayer


@onready var distance_label: Label = $Panel/DistanceLabel
@onready var game_over_screen: PanelContainer = $GameOverScreen
@onready var score_label: Label = $GameOverScreen/VBoxContainer/Score
@onready var replay: Button = $GameOverScreen/VBoxContainer/HBoxContainer/Replay
@onready var quit: Button = $GameOverScreen/VBoxContainer/HBoxContainer/Quit


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("replay"):
		get_tree().reload_current_scene()


func _ready() -> void:
	game_over_screen.visible = false
	replay.pressed.connect(func():
		get_tree().reload_current_scene())
	quit.pressed.connect(func():
		get_tree().change_scene_to_file("res://scenes/menu.tscn"))


func update_score(distance_travelled: int) -> void:
	distance_label.text = "Distance: " + str(distance_travelled) + "m"


func show_game_over(score: int) -> void:
	game_over_screen.visible = true
	score_label.text = str(score) + "m"
