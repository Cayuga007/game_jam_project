extends Node2D


const MAX_SAFE_OBSTACLES = 20
const START_OBSTACLE_X = 125
const BALLOON_Y = 125
const OBSTACLE_SPACING = 100

const BIRD_SPAWN_TIMER = 1#15
const BIRD_SPAWN_OFFSET = 0#5
const INITIAL_BIRD_SPAWN_OFFSET = 0#10
const BIRD_SPACING = 500

const BALLOON = preload("res://scenes/bloon.tscn")
const CLOUD = preload("res://scenes/cloud.tscn")
const BIRD = preload("res://scenes/bird.tscn")

@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D

var obstacle_offset: float = START_OBSTACLE_X
var time_since_bird_spawn: float = 0.0
var next_bird_spawn_time: float = 0.0


func _ready() -> void:
	generate_first_obstacles()
	set_bird_spawn_time()
	next_bird_spawn_time += INITIAL_BIRD_SPAWN_OFFSET
	
	player.obstacle_hit.connect(func():
		spawn_new_balloon_or_cloud())


func _process(delta: float) -> void:
	time_since_bird_spawn += delta
	if time_since_bird_spawn >= next_bird_spawn_time:
		spawn_new_bird()
		set_bird_spawn_time()
	camera.position.x = player.position.x


func generate_first_obstacles() -> void:
	var first_obstacle = create_new_balloon()
	first_obstacle.position = Vector2(START_OBSTACLE_X, BALLOON_Y)
	for i in range(MAX_SAFE_OBSTACLES):
		spawn_new_balloon_or_cloud()


func create_new_balloon() -> Balloon:
	var new_balloon = BALLOON.instantiate()
	get_tree().current_scene.call_deferred("add_child", new_balloon)
	return new_balloon


func create_new_bird() -> Bird:
	var new_bird = BIRD.instantiate()
	get_tree().current_scene.call_deferred("add_child", new_bird)
	return new_bird


func create_new_cloud() -> Cloud:
	var new_cloud = CLOUD.instantiate()
	get_tree().current_scene.call_deferred("add_child", new_cloud)
	return new_cloud


func spawn_new_balloon_or_cloud() -> void:
	var new_obstacle: Obstacle
	if randf() < 0.75:
		new_obstacle = create_new_balloon()
		new_obstacle.position.y = BALLOON_Y
	else:
		new_obstacle = create_new_cloud()
		new_obstacle.position.y = randi_range(BALLOON_Y - 10, BALLOON_Y)
	obstacle_offset += OBSTACLE_SPACING
	new_obstacle.position.x = obstacle_offset


func spawn_new_bird() -> void:
	var new_bird = create_new_bird()
	new_bird.position.x = player.position.x + BIRD_SPACING
	new_bird.position.y = randi_range(0, 500)


func set_bird_spawn_time() -> void:
	time_since_bird_spawn = 0.0
	next_bird_spawn_time = BIRD_SPAWN_TIMER + randf_range(-BIRD_SPAWN_OFFSET, BIRD_SPAWN_OFFSET)
