extends Node2D
class_name SkillNode

var mana: int = 0:
	set(value):
		mana = clamp(value, 0, skill.cost)
		if mana == skill.cost:
			$Skin.modulate = "ffffff"
			$ColorRect.modulate = "ffffff"
		else:
			$Skin.modulate = "7d7d7d"
			$ColorRect.modulate = "7d7d7d"

		$Mana.text = str(mana)

@export var skill: Skill:
	set(value):
		skill = value
		if not is_inside_tree():
			await ready
		$Title.text = skill.title
		$Skin.texture = skill.texture
		$ColorRect.color = Database.get_color(skill.type)
		$MaxMana.text = str(skill.cost)




func add_mana(dice: DiceNode) -> void:
	if check_validity(dice.get_current_face_type(), dice.get_current_face_value()) and not mana == skill.cost:
		mana += dice.get_current_face_value() + dice.bonus
		dice.disabled = true


func check_validity(t: Database.Types, _v: int) -> bool:
	if t == skill.type:
		return true
	else:
		return false




func _on_button_pressed() -> void:
	if GameState.inputable and mana == skill.cost:
		get_tree().current_scene.add_action(skill.effect.bind(get_tree()))
		mana = 0
