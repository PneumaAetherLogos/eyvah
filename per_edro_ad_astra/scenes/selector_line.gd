extends Node2D

var active: bool = false:
	set(value):
		active = value
		visible = value

var description: String:
	set(value):
		description = value
		$Label.text = description
		

@export var control_offset := Vector2(0, -100)
@export var points_count := 20

var origin := Vector2.ZERO
var destination := Vector2.ZERO

func _process(_delta: float) -> void:
	if not active:
		return
	
	origin = to_local(global_position)
	destination = get_local_mouse_position()

	draw_curved_line(origin, destination)
	
	$Label.position = get_local_mouse_position() - $Label.size / 2 - Vector2(0, 10)

func draw_curved_line(from: Vector2, to: Vector2) -> void:
	$Line.clear_points()
	for i in points_count:
		var t := i / float(points_count - 1)
		
		var control_point := from.lerp(to, 0.5) + control_offset
		
		var a := from.lerp(control_point, t)
		var b := control_point.lerp(to, t)
		var point := a.lerp(b, t)
		
		$Line.add_point(point)
