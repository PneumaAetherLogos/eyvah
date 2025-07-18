extends Node2D

@export var target_position: Vector2
@export var duration := 0.6
@export var delay := 0.0

var timer := 0.0
var control_point := Vector2()
var start_position := Vector2()
var is_active := false

func _ready():
	start_position = global_position

	control_point = start_position.lerp(target_position, 0.5) + Vector2(
		randf_range(-40, 40),
		randf_range(-120, -60)
	)

	if delay > 0.0:
		await get_tree().create_timer(delay).timeout

	is_active = true

func _process(delta: float) -> void:
	if not is_active:
		return

	timer += delta
	var t = clamp(timer / duration, 0.0, 1.0)

	# Quadratic Bezier interpolation
	var a = start_position.lerp(control_point, t)
	var b = control_point.lerp(target_position, t)
	global_position = a.lerp(b, t)

	if t >= 1.0:
		get_tree().get_first_node_in_group("PLAYER").gain_xp(1)
		queue_free()
