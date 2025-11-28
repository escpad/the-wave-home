extends Node2D

@export var ripple_scene: PackedScene
@export var bubble_scene: PackedScene

var bubble: Bubble

func _ready() -> void:
	bubble = bubble_scene.instantiate()
	bubble.position = Vector2(50, 50)
	add_child(bubble)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_spawn_ripple(event.position)

func _spawn_ripple(origin: Vector2) -> void:
	if ripple_scene == null:
		return

	var r = ripple_scene.instantiate()
	r.position = origin
	add_child(r)

	if r.has_signal("wave_force"):
		r.wave_force.connect(_on_wave_force)

func _on_wave_force(origin: Vector2, radius: float, strength: float) -> void:
	if bubble == null:
		return

	var dist: float = bubble.global_position.distance_to(origin)

	if abs(dist - radius) < 20.0:
		var dir: Vector2 = (bubble.global_position - origin).normalized()
		var force: Vector2 = dir * strength * 0.01
		bubble.apply_wave_force(force)
