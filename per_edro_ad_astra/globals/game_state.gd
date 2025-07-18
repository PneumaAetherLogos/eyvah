extends Node

signal turn_start
signal turn_end
signal dice_roll



var inputable: bool = true



const floating_text = preload("res://scenes/floating_text.tscn")
const flying_orb = preload("res://scenes/flying_orb.tscn")


func spawn_xp(amount: int, starting_pos: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("PLAYER")
	if not player: return
	var target_pos = player.get_node("XpBar").global_position

	for i in range(amount):
		var orb = flying_orb.instantiate()

		orb.global_position = starting_pos + Vector2(
			randf_range(-32, 32),
			randf_range(-32, 32)
		)

		orb.target_position = target_pos
		orb.delay = randf_range(0.0, 0.3)
		orb.duration = randf_range(0.4, 0.7)

		get_tree().current_scene.add_child(orb)
