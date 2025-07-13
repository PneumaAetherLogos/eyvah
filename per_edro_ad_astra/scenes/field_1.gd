extends Node2D



func _on_child_exiting_tree(_node: Node) -> void:
	call_deferred("flip_top_card")
	
	
func flip_top_card() -> void:
	if get_children().is_empty(): return

	var child: CardNode = get_child(-1)
	
	child.flipped = true
