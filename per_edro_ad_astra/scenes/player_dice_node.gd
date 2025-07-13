extends DiceNode
class_name PlayerDiceNode

var is_held: bool = false:
	set(value):
		is_held = value
		if is_held: 
			z_index = 100
		elif not is_held:
			global_position = initial_pos
			z_index = 0

var initial_pos: Vector2

func _process(_delta: float) -> void:
	if is_held:
		global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("TEST"):
		roll()



func _on_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:

	if disabled: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and not is_held:
				initial_pos = global_position
				is_held = true
		
			elif not event.pressed and is_held:
				drop()


func drop() -> void:
	if not $Area.get_overlapping_areas().is_empty():
		var area = $Area.get_overlapping_areas()[0]
		if area.owner is CardNode:
			attack(area.owner)
		else:
			is_held = false

	else: is_held = false


func attack(target: CardNode) -> void:
	if target.viable and target.check_validity(get_current_face_type(), get_current_face_value()):
		target.take_damage(get_current_face_value())
		disabled = true
	is_held = false



func on_turn_end() -> void:
	print("d")
	disabled = true



func get_current_face_type() -> Database.Types:
	return dice.face_types[current_face]

func get_current_face_value() -> int:
	return dice.values[current_face]
