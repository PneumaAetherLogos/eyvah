extends Marker2D

@onready var label = $Label


enum TextType {Damage}

var type: TextType = TextType.Damage
var number: int = 0



func _ready() -> void:
	
	var string: String = ""
	
	match type:
		TextType.Damage:
			$Label.set("theme_override_colors/font_color", "f5adae")
			string += "-"
	
	string += str(number)
	$Label.text = string
	tweener()

func tweener() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, -10), 0.4).as_relative()
	await tween.finished
	await get_tree().create_timer(0.3).timeout
	queue_free()
