extends PlayerDiceNode
class_name SummonDiceNode

var turns: int = 1:
	set(value):
		turns = value
		%Turns.text = str(turns)
		if turns <= 0:
			queue_free()



func on_turn_end() -> void:
	turns -= 1
