extends Node2D
class_name CardNode

@export var enemy: Enemy:
	set(value):
		enemy = value
		if not value: return
		if not is_inside_tree():
			await ready
		$Skin.texture = enemy.texture
		$Title.text = enemy.title
		health = enemy.health
		$Conditions.set_condition_visuals(enemy.conditions)
		$DiceNode.dice = enemy.dice

var health: int:
	set(value):
		health = value
		$Health.text = str(health)

var flipped: bool = false:
	set(value):
		flipped = value
		if flipped:
			$Animations.play("FLIP")
		else:
			$Animations.play_backwards("FLIP")
		
		$Area.monitoring = value
		$Area.monitorable = value
		viable = value

var viable: bool = false


func _ready() -> void:
	$DiceNode.disabled = true
	rotation_degrees = randf_range(-10, 10)
	get_tree().current_scene.turn_start.connect(turn_start)


func turn_start() -> void:
	if viable:
		$DiceNode.on_turn_start()


func check_validity(t: Database.Types, v: int) -> bool:
	for con in enemy.conditions:
		if con.check_validity(t, v):
			return true

	return false



func attack() -> void:
	var die = $DiceNode
	if die.disabled: return
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, 10), 0.1)
	get_player().hp -= die.get_current_face_value()
	tween.tween_property(self, "position", Vector2.ZERO, 0.3)
	await tween.finished
	tween.kill()


func take_damage(value: int) -> void:
	health -= value
	if health <= 0:
		death()

func death() -> void:
	viable = false
	var gain_xp: int 
	if health == 0: gain_xp = 6
	else: gain_xp = 3
	get_tree().get_first_node_in_group("PLAYER").xp += gain_xp
	
	$Animations.play("DEATH")
	await $Animations.animation_finished
	reparent(get_tree().current_scene)
	queue_free()

func get_player() -> Node2D:
	return get_tree().get_first_node_in_group("PLAYER")
