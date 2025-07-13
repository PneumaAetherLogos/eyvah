extends Node2D
class_name DiceNode

@export var dice: Dice:
	set(value):
		dice = value
		if not value: return
		elif not is_inside_tree():
			await ready
		
		$Skin.texture = dice.texture
		change_face()

var current_face: int:
	set(value):
		current_face = value
		%Value.text = str(dice.values[value])
		%Value.set("theme_override_colors/font_color", Database.get_color(dice.face_types[value]))



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


func on_turn_start() -> void:
	roll()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("TEST"):
		roll()


func on_turn_end() -> void:
	pass



func attack(_target: CardNode) -> void:
	pass





func get_current_face_type() -> Database.Types:
	return dice.face_types[current_face]

func get_current_face_value() -> int:
	return dice.values[current_face]
