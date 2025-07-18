extends Node2D

const CARD_NODE: PackedScene = preload("res://scenes/character_nodes/enemy_card_node.tscn")
const SKIRMISHER = preload("res://resources/cards/enemies/skirmisher.tres")

func _ready() -> void:
	var count = 0
	for field in get_children():
		for i in 10:
			count += 1
			deal_to_field(field.get_index(), count % 6 == 0)
		field.flip_top_card()

func on_turn_end() -> void:
	for field in get_children():
		if field.get_children().is_empty(): continue
		var child = field.get_child(-1)
		if child is CardNode and child.viable:
			get_tree().current_scene.add_action(child.attack)



func deal_to_field(field: int, sk: bool = false) -> void:
	var instance = CARD_NODE.instantiate()
	if sk: instance.card = SKIRMISHER.duplicate()
	get_child(field).add_child(instance)
