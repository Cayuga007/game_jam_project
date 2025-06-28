class_name Cloud extends Obstacle


const CLOUD_TRAVEL_SPEED = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible_on_screen.is_on_screen():
		position.x -= CLOUD_TRAVEL_SPEED * delta
