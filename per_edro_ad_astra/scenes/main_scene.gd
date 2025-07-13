extends Node2D

signal turn_end
signal turn_start


func _on_end_turn_pressed() -> void:
	end_turn()


func end_turn() -> void:
	$EndTurn.disabled = true
	turn_end.emit()
	await $Fields.on_turn_end()
	turn_start.emit()
	$EndTurn.disabled = false
	
func _ready() -> void:
	turn_start.emit()
