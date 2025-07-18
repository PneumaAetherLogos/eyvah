extends Node2D


func set_condition_visuals(conds: Array[Condition]) -> void:
	for con in conds:
		var string: String = ""
		var child: Label = get_child(conds.find(con))
		match con.comperator:
			Condition.Comperator.LOWER:
				string += "<"
			Condition.Comperator.GREATER:
				string += ">"
			_:
				string += ""
		
		if con.comperator == Condition.Comperator.NONE:
			string += "ANY"
			child.set("theme_override_font_sizes/font_size", 6)
		else:
			string += str(con.value)
		
		
		child.text = string
		child.set("theme_override_colors/font_color", Database.get_color(con.type))
