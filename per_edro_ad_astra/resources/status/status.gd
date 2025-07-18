extends Resource
class_name Status


@export var title: String
@export var texture: Texture2D

var nest: CharacterCardNode
var amount: int = 0: set = amount_setter




func amount_setter(value: int) -> void:
	amount = value
	amount_change(value)


func effect() -> void:
	pass

func amount_change(_v) -> void:
	pass
