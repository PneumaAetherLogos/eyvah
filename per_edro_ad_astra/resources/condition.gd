extends Resource
class_name Condition


enum Comperator {LOWER, EQUAL, GREATER, NONE}


@export var type: Database.Types = Database.Types.ANY
@export var comperator: Comperator = Comperator.NONE
@export var value: int = 0




func check_validity(t: Database.Types, v: int) -> bool:

	if not type == Database.Types.ANY and not t == type:
		return false
		
	else:
		match comperator:
			Comperator.NONE:
				return true
			Comperator.LOWER:
				return v < value
			Comperator.EQUAL:
				return v == value
			Comperator.GREATER:
				return v > value
			_:
				return false
