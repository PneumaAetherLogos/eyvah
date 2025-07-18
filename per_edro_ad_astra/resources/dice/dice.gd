extends Resource
class_name Dice

const FACE_NUMBER: int = 6

@export var title: String

@export var texture: Texture2D


@export var values: Array[int]
@export var face_types: Array[Database.Types]

@export var description: String

var nest: DiceNode: set = nest_setter

func effect() -> void:
	pass

func nest_setter(value) -> void:
	nest = value
