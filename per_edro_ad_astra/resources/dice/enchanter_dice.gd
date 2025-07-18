extends Dice


func nest_setter(value) -> void:
	nest = value
	nest.bonus_gain.connect(effect)
	GameState.turn_start.connect(effect)


func effect() -> void:
	nest.get_tree().current_scene.add_action(gain_bonus)
	
func gain_bonus() -> void:
	nest.bonus += 1
