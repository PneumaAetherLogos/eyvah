extends Node2D

var in_action: bool = false:
	set(value):
		in_action = value
		GameState.inputable = not value
		$EndTurn.disabled = value

var queue: Array[Callable] = []

var waiting_for_turn_start: bool = false

func take_action() -> void:
	if queue.is_empty():
		in_action = false

		if waiting_for_turn_start:
			waiting_for_turn_start = false
			start_turn()

		return

	in_action = true
	var callable: Callable = queue.pop_front()
	await callable.call()
	await take_action()


func add_action(c: Callable) -> void:
	queue.append(c)
	if not in_action:
		take_action()


func _on_end_turn_pressed() -> void:
	if not GameState.inputable: return
	end_turn()


func end_turn() -> void:
	GameState.turn_end.emit()
	$EndTurn.disabled = true
	waiting_for_turn_start = true
	add_action($Fields.on_turn_end)
	

func start_turn() -> void:
	add_action(roll_all)
	GameState.turn_start.emit()
	

func roll_all() -> void:
	var enemies = get_tree().get_nodes_in_group("ENEMY_DICE")
	var player = get_tree().get_nodes_in_group("PLAYER_DICE")
	for i in enemies:
		i.on_turn_start()
	var last = player.pop_back()
	for i in player:
		i.on_turn_start()
	await last.on_turn_start()
	
func _ready() -> void:
	start_turn()
