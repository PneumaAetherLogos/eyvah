extends Node2D
class_name CardNode



func get_player() -> Node2D:
	return get_tree().get_first_node_in_group("PLAYER")
