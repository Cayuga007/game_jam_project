extends Node2D


const MAX_SAFE_OBSTACLES = 10
const OBSTACLE_SPACING = 200

const BIRD_SPAWN_TIMER = 1#15
const BIRD_SPAWN_OFFSET = 0#5
const INITIAL_BIRD_SPAWN_OFFSET = 0#10

const BALLOON = preload("res://balloon.tscn")
const CLOUD = preload("res://cloud.tscn")
const BIRD = preload("res://bird.tscn")

var latest_obstacle: Obstacle
var time_since_bird_spawn: float = 0.0
var next_bird_spawn_time: float = 0.0


func _ready() -> void:
	generate_first_balloons()
	generate_clouds()
	generate_birds()
	set_bird_spawn_time()
	next_bird_spawn_time += INITIAL_BIRD_SPAWN_OFFSET


func _process(delta: float) -> void:
	time_since_bird_spawn += delta
	if time_since_bird_spawn >= next_bird_spawn_time:
		spawn_new_bird()
		set_bird_spawn_time()


func generate_first_balloons() -> void:
	latest_obstacle = create_new_balloon()
	latest_obstacle.position = Vector2(250, 500)
	for i in MAX_SAFE_OBSTACLES:
		spawn_new_balloon_or_cloud()


func generate_clouds() -> void:
	pass


func generate_birds() -> void:
	pass


func create_new_balloon() -> Balloon:
	var new_balloon = BALLOON.instantiate()
	get_tree().current_scene.add_child(new_balloon)
	return new_balloon


func create_new_bird() -> Bird:
	var new_bird = BIRD.instantiate()
	get_tree().current_scene.add_child(new_bird)
	return new_bird


func create_new_cloud() -> Cloud:
	var new_cloud = CLOUD.instantiate()
	get_tree().current_scene.add_child(new_cloud)
	return new_cloud


func spawn_new_balloon_or_cloud() -> void:
	var new_obstacle: Obstacle
	if randf() < 0.75:
		new_obstacle = create_new_balloon()
		new_obstacle.position.y = latest_obstacle.position.y
	else:
		new_obstacle = create_new_cloud()
		new_obstacle.position.y = randi_range(500, 700)
	new_obstacle.position.x = latest_obstacle.position.x + OBSTACLE_SPACING
	latest_obstacle = new_obstacle


func spawn_new_bird() -> void:
	var new_bird = create_new_bird()
	new_bird.position.x = 500 # Player.position.x + offset
	new_bird.position.y = randi_range(0, 500)


func set_bird_spawn_time() -> void:
	time_since_bird_spawn = 0.0
	next_bird_spawn_time = BIRD_SPAWN_TIMER + randf_range(-BIRD_SPAWN_OFFSET, BIRD_SPAWN_OFFSET)
