extends Node2D

const DICE_NODE: PackedScene = preload("res://scenes/dice_nodes/player_dice_node.tscn")


@export var spacing: float = 100.0
@export var arc_strength: float = 0.02  # Curve intensity
@export var animation_duration := 0.4


func _ready() -> void:
	for i in 4:
		var instance = DICE_NODE.instantiate()



		add_child(instance)
	layout_hand()


func layout_hand(animated := true):
	var count = get_child_count()
	if count == 0:
		return

	var start_x = -((count - 1) * spacing) / 2.0

	for i in count:
		var card = get_child(i)
		var target_pos = Vector2(start_x + i * spacing, 0)
		var offset_y = -pow(abs((i - count / 2.0)), 2) * arc_strength * spacing
		target_pos.y += offset_y

		var target_rotation = deg_to_rad((i - count / 2.0) * 5.0)

		if animated:
			var tween = create_tween()
			tween.tween_property(card, "position", target_pos, animation_duration)
			tween.parallel().tween_property(card, "rotation", target_rotation, animation_duration)
		else:
			card.position = target_pos
			card.rotation = target_rotation
