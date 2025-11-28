extends CharacterBody2D
class_name Bubble

@export var friction: float = 2.0
@export var bounce_damping: float = 0.8   # lose 20% speed on bounce
@export var max_speed: float = 250.0      # hard speed cap

var last_position: Vector2

func _ready() -> void:
	last_position = global_position

func _physics_process(delta: float) -> void:
	last_position = global_position

	_clamp_speed()

	# Move with collision
	var motion: Vector2 = velocity * delta
	var collision: KinematicCollision2D = move_and_collide(motion)

	if collision:
		var normal: Vector2 = collision.get_normal()
		velocity = velocity.bounce(normal) * bounce_damping

	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	_clamp_to_screen()


func apply_wave_force(force: Vector2) -> void:
	velocity += force
	_clamp_speed()


func _clamp_speed() -> void:
	var speed: float = velocity.length()
	if speed > max_speed:
		velocity = velocity.normalized() * max_speed


func _clamp_to_screen() -> void:
	var radius: float = 8.0

	var screen_width: float = 480.0
	var screen_height: float = 270.0

	var pos: Vector2 = global_position

	var bounced_x := false
	var bounced_y := false

	# Left wall
	if pos.x < radius:
		pos.x = radius
		bounced_x = true

	# Right wall
	if pos.x > screen_width - radius:
		pos.x = screen_width - radius
		bounced_x = true

	# Top wall
	if pos.y < radius:
		pos.y = radius
		bounced_y = true

	# Bottom wall
	if pos.y > screen_height - radius:
		pos.y = screen_height - radius
		bounced_y = true

	if bounced_x:
		velocity.x = -velocity.x * bounce_damping
	if bounced_y:
		velocity.y = -velocity.y * bounce_damping

	global_position = pos
