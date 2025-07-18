extends Node2D

const CARD_NODE: PackedScene = preload("res://scenes/character_nodes/enemy_card_node.tscn")

func _ready() -> void:
	for field in get_children():
		for i in 3:
			deal_to_field(field.get_index())
		field.flip_top_card()

func on_turn_end() -> void:
	for field in get_children():
		if field.get_children().is_empty(): continue
		var child = field.get_child(-1)
		if child is CardNode and child.viable:
			get_tree().current_scene.add_action(child.attack)



func deal_to_field(field: int) -> void:
	var instance = CARD_NODE.instantiate()
	get_child(field).add_child(instance)
