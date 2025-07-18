extends CharacterCardNode
class_name PlayerCardNode


@export var max_xp: int = 30:
	set(value):
		max_xp = value
		if not is_inside_tree():
			await ready
		%MaxXp.text = str(max_xp)
		
var xp: int = 0:
	set(value):
		xp = value
		if not is_inside_tree():
			await ready
		%Xp.text = str(xp)

func _ready() -> void:
	flipped = true


func gain_xp(value: int) -> void:
	xp += value
	label_tweener(%Xp)



var label_tween: Tween
func label_tweener(label: Label) -> void:
	if label_tween: label_tween.kill()
	label_tween = create_tween()
	label_tween.tween_property(label, "scale", Vector2(1.5, 1.5), 0.1)
	label_tween.tween_property(label, "scale", Vector2.ONE, 0.1)
