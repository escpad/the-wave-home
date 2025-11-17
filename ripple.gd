extends Node2D
class_name Ripple

signal wave_force(origin: Vector2, radius: float, strength: float)

var radius: float = 0.0
var max_radius: float = 200.0
var grow_speed: float = 200.0
var alpha: float = 1.0
var fade_speed: float = 1.2
var base_color: Color = Color(0.2, 0.7, 1.0, 1.0)
var line_thickness: float = 4.0

func _process(delta: float) -> void:
	radius += grow_speed * delta
	alpha -= fade_speed * delta

	# Emit a wave with diminishing strength
	var strength := alpha * 500.0
	emit_signal("wave_force", global_position, radius, strength)

	if alpha <= 0 or radius > max_radius:
		queue_free()
		return

	queue_redraw()

func _draw() -> void:
	var c = base_color
	c.a = alpha
	draw_arc(Vector2.ZERO, radius, 0, TAU, 64, c, line_thickness)
