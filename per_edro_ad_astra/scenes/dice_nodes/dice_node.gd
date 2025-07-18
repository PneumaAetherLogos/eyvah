extends Node2D
class_name DiceNode

signal bonus_gain
signal rolled

@export var dice: Dice:
	set(value):
		dice = value
		if not value: return
		dice.nest = self
		if not is_inside_tree():
			await ready
		
		$Skin.texture = dice.texture
		change_face()

var current_face: int:
	set(value):
		current_face = value
		%Value.text = str(dice.values[value])
		%Value.set("theme_override_colors/font_color", Database.get_color(dice.face_types[value]))

var bonus: int = 0:
	set(value):
		bonus = value
		$Bonus.text = "+" + str(bonus)
		$Bonus.visible = not bonus == 0
		label_tweener($Bonus)
		

@export var disabled: bool = false:
	set(value):
		disabled = value
		if value:
			modulate = "808080"
		else:
			modulate = "ffffff"


func change_face() -> void:
	current_face = randi_range(0, 5)

func roll() -> void:
	$Animations.play("ROLL")
	await $Animations.animation_finished
	change_face()
	rolled.emit()


func on_turn_start() -> void:
	disabled = false
	bonus = 0
	await roll()
	get_character()


func on_turn_end() -> void:
	pass

func gain_bonus(value: int) -> void:
	bonus += value
	bonus_gain.emit()

func attack(_target: CardNode) -> void:
	pass





func get_current_face_type() -> Database.Types:
	return dice.face_types[current_face]

func get_current_face_value() -> int:
	return dice.values[current_face]




var label_tween: Tween
func label_tweener(label: Label) -> void:
	if label_tween: label_tween.kill()
	label_tween = create_tween()
	label_tween.tween_property(label, "scale", Vector2(2, 2), 0.2)
	label_tween.tween_property(label, "scale", Vector2.ONE, 0.2)
	

func get_character() -> CharacterCardNode:
	return owner
