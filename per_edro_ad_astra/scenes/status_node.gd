extends TextureRect
class_name StatusNode

@export var status: Status:
	set(value):
		status = value
		if not is_inside_tree():
			await ready
		status.nest = get_parent().get_parent()
		texture = status.texture

var amount: int: 
	set(value):
		amount = value
		status.amount = value
		if not is_inside_tree():
			await ready
		$Label.text = str(value)
		if value <= 0:
			queue_free()

func _ready() -> void:
	GameState.turn_start.connect(on_turn_start)

func on_turn_start() -> void:
	status.effect()
	amount -= 1
