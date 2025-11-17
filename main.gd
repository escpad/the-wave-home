extends Node2D

@export var ripple_scene: PackedScene
@export var bubble_scene: PackedScene

var bubble: Bubble

func _ready():
	# Spawn 1 bubble in the middle (or wherever)
	bubble = bubble_scene.instantiate()
	bubble.position = Vector2(400, 300)
	add_child(bubble)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var r = ripple_scene.instantiate()
		r.position = event.position
		add_child(r)
		r.wave_force.connect(_on_wave_force)

func _on_wave_force(origin: Vector2, radius: float, strength: float) -> void:
	if not bubble:
		return

	var dist = bubble.global_position.distance_to(origin)

	# If bubble is near the ripple's current ring
	if abs(dist - radius) < 20.0:
		var dir = (bubble.global_position - origin).normalized()
		var force = dir * strength * 0.01
		bubble.apply_wave_force(force)
