extends SkillNode
class_name TargetSkillNode

var active: bool = false:
	set(value):
		active = value
		$SelectorLine.active = value
		if value:
			add_to_group("ACTIVATED")
		else:
			remove_from_group("ACTIVATED")


func _ready() -> void:
	if skill: $SelectorLine.description = skill.description

func _on_button_pressed() -> void:
	if GameState.inputable and mana == skill.cost:
		active = not active

func check_target(node: Node2D) -> bool:
	return node.is_in_group(skill.target)


func activate(target: Node2D) -> void:
	if not target: return
	if not check_target(target): return
	
	get_tree().current_scene.add_action(skill.effect.bind(get_tree(), target))
	active = false
	mana = 0
