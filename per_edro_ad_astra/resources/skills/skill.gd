extends Resource
class_name Skill



@export var title: String
@export var texture: Texture

@export var type: Database.Types

@export var value: int = 0
@export var cost: int

@export var description: String = ""

func effect(_tree: SceneTree, _target: Node2D = null) -> void:
	pass
