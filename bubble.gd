extends Node2D
class_name Bubble

var velocity: Vector2 = Vector2.ZERO
var friction: float = 2.0   # slows down movement

func _physics_process(delta: float) -> void:
	# apply velocity
	position += velocity * delta

	# slow down over time
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func apply_wave_force(force: Vector2) -> void:
	velocity += force
