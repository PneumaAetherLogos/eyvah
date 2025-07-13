extends Resource
class_name Enemy

@export var title: String = "UNUTMA!"
@export var texture: Texture2D

@export var health: int = 1

@export var conditions: Array[Condition] = []
@export var dice: Dice
