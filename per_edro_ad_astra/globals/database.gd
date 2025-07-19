extends Node


const WINDOW_SIZE: Vector2 = Vector2(640, 360)

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
				color = "559e9e"
			Database.Types.AETHER:
				color = "9c173b"
			Database.Types.LOGOS:
				color = "802169"
			_:
				color = Color.WHITE

		return color
