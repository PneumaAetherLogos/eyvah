extends CardNode
class_name CharacterCardNode

@export var card: Card: set = card_setter

var max_health: int:
	set(value):
		max_health = value
		%MaxHealth.text = str(max_health)
		health = clamp(health, 0, max_health)
	
	
var health: int: set = health_setter

var armor: int = 0:
	set(value):
		armor = value
		if not is_inside_tree():
			await ready
		%Armor.text = str(armor)
		$ArmorBar.visible = armor > 0



var flipped: bool = false: set = flipped_setter








func take_damage(value: int) -> void:
	armor -= value
	if armor < 0:
		health += armor
		armor = 0

	$Animations.play("SHAKE")
	if health <= 0:
		death()
	var instance = GameState.floating_text.instantiate()
	instance.number = value
	instance.type = instance.TextType.Damage
	instance.position = $HpBar.position - Vector2(0, 10)
	add_child(instance)

func add_status(status: Status, amount: int) -> void:
	$StatusEffects.add_status(status, amount)

func death() -> void:
	
	for i in get_groups():
		remove_from_group(i)
	
	$Animations.play("DEATH")
	await $Animations.animation_finished
	reparent(get_parent())
	queue_free()



func gain_armor(value: int) -> void:
	armor += value




func card_setter(value: Card) -> void:
	card = value
	if not is_inside_tree():
		await ready
	$Skin.texture = card.texture
	$Title.text = card.title
	max_health = card.max_health
	health = max_health

func health_setter(value: int) -> void:
	health = value
	%Health.text = str(health)
	
func flipped_setter(value: bool) -> void:
	flipped = value
	if flipped:
		$Animations.play("FLIP")
		add_to_group("CHARACTER")
	else:
		$Animations.play_backwards("FLIP")
		remove_from_group("CHARACTER")
	
	$Area.monitoring = value
	$Area.monitorable = value


func _on_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var active: TargetSkillNode = get_tree().get_first_node_in_group("ACTIVATED")
			if active:
				active.activate(self)
