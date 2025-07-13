extends Node2D


@export var max_hp: int = 30:
	set(value):
		max_hp = value
		%MaxHealth.text = str(max_hp)
		
		
var hp: int = 30:
	set(value):
		hp = value
		%Health.text = str(hp)

@export var max_xp: int = 30:
	set(value):
		max_xp = value
		%MaxXp.text = str(max_xp)
		
var xp: int = 0:
	set(value):
		xp = value
		%Xp.text = str(xp)

func _ready() -> void:
	max_hp = max_hp
	hp = hp
	max_xp = max_xp
	xp = xp
