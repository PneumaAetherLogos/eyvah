extends CharacterCardNode
class_name EnemyCardNode



var viable: bool = false:
	set(value):
		viable = value
		if value:
			$DiceNode.add_to_group("ENEMY_DICE")
		else:
			$DiceNode.remove_from_group("ENEMY_DICE")




func _ready() -> void:
	$DiceNode.disabled = true
	rotation_degrees = randf_range(-10, 10)



func turn_start() -> void:
	if viable:
		await $DiceNode.on_turn_start()


func check_validity(t: Database.Types, v: int) -> bool:
	for con in card.conditions:
		if con.check_validity(t, v):
			return true

	return false



func attack() -> void:
	var die = $DiceNode
	if die.disabled: return
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, 10), 0.1)
	get_player().take_damage(die.get_current_face_value())
	tween.tween_property(self, "position", Vector2.ZERO, 0.3)
	await tween.finished
	tween.kill()
	


func death() -> void:
	viable = false
	var gain_xp: int 
	if health == 0: gain_xp = 6
	else: gain_xp = 3
	GameState.spawn_xp(gain_xp, global_position)
	
	$Animations.play("DEATH")
	await $Animations.animation_finished
	reparent(get_tree().current_scene)
	queue_free()



func card_setter(value: Card) -> void:
	if value is not Enemy: return
	card = value
	if not is_inside_tree():
		await ready
	$Skin.texture = card.texture
	$Title.text = card.title
	max_health = card.max_health
	health = max_health
	$Conditions.set_condition_visuals(card.conditions)
	$DiceNode.dice = card.dice

func flipped_setter(value: bool) -> void:
	super.flipped_setter(value)
	if value:
		add_to_group("ENEMY")
	else:
		remove_from_group("ENEMY")
	viable = value
