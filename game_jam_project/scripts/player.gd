class_name Player extends CharacterBody2D


signal obstacle_hit

const SPEED = 250.0
const JUMP_VELOCITY = 8.0
const MAX_JUMP_TIME = 0.25

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var jumping: bool = false
var jump_t: float = 0.0
var lost: bool = false

func _physics_process(delta: float) -> void:
	if lost: return
	
	# Add the gravity.
	if not is_on_floor() and not jumping:
		velocity += get_gravity() * 2 * delta
	elif jumping:
		jump_t += delta
		if jump_t < MAX_JUMP_TIME:
			position.y -= JUMP_VELOCITY
		else:
			jump_t = 0.0
			jumping = false
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
	if Input.is_action_just_released("jump"):
		jumping = false
		jump_t = 0.0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Balloon or body is Cloud) and not body.landed_on:
		body.remove_self()
		obstacle_hit.emit()
