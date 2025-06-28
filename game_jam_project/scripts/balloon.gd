class_name Balloon extends Obstacle


enum BalloonType {RED, BLUE, YELLOW}

const RED_SPEED = 10
const BLUE_SPEED = 20
const YELLOW_SPEED = 30

var balloon_type: BalloonType
var rise_speed: float


func _ready() -> void:
	var random_type = randi_range(0, 2)
	match random_type:
		BalloonType.RED:
			balloon_type = BalloonType.RED
			rise_speed = RED_SPEED
		BalloonType.BLUE:
			balloon_type = BalloonType.BLUE
			rise_speed = BLUE_SPEED
		BalloonType.YELLOW:
			balloon_type = BalloonType.YELLOW
			rise_speed = YELLOW_SPEED


func _process(delta: float) -> void:
	if visible_on_screen.is_on_screen():
		position.y -= rise_speed * delta
