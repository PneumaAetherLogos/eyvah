extends Dice




func nest_setter(v) -> void:
	nest = v
	if not v: return
	nest.rolled.connect(on_rolled)
	


func on_rolled() -> void:
	nest.get_tree().current_scene.add_action(effect)

func effect() -> void:
	var character: CharacterCardNode = nest.get_character()
	character.gain_armor(nest.get_current_face_value())
