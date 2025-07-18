extends Node


enum Types {PNEUMA, AETHER, LOGOS, ANY}


const STATUS: Dictionary = {
	"BURN" = preload("res://resources/status/burn.tres")
}


func get_status(title: String) -> Status:
	return STATUS[title].duplicate()

func get_color(type: Types) -> Color:
		var color: Color = Color.WHITE
		
		match type:
			Database.Types.PNEUMA:
				color = "8ea8b8"
			Database.Types.AETHER:
				color = "9c173b"
			Database.Types.LOGOS:
				color = "6f1d5c"
			_:
				color = Color.WHITE

		return color
