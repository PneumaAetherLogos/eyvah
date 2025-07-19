extends ActiveSkill


func effect(tree: SceneTree, t = null) -> void:
	t.take_damage(value)
	if t.health == 0:
		await tree.get_first_node_in_group("HAND").summon_dice(t.card.dice)
