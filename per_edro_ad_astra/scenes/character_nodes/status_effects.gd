extends GridContainer


const STATUS_NODE = preload("res://scenes/status_node.tscn")

func add_status(status: Status, amount: int) -> void:
	for i: StatusNode in get_children():
		if i.status.title == status.title:
			i.amount += amount
			return
	
	var instance = STATUS_NODE.instantiate()
	instance.status = status
	instance.amount = amount
	add_child(instance)
