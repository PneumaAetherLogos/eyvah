extends Skill


@export var frames: SpriteFrames

func effect(tree: SceneTree, _t = null) -> void:
	
	var anim: AnimatedSprite2D = AnimatedSprite2D.new()
	anim.sprite_frames = frames
	anim.position = Vector2(240, 135)
	anim.z_index = 100
	tree.current_scene.add_child(anim)
	anim.play()
	
	await animator(anim)
	


func animator(anim: AnimatedSprite2D) -> void:
	var tween: Tween = anim.create_tween()
	tween.tween_property(anim, "scale", Vector2(4, 4), 0.6)
	await tween.finished
	for character: CharacterCardNode in anim.get_tree().get_nodes_in_group("CHARACTER"):
		character.take_damage(value)
		character.add_status(Database.get_status("BURN"), 2)

	var tween2: Tween = anim.create_tween()
	tween2.tween_property(anim, "scale", Vector2(20, 20), 0.4)
	await tween2.finished
	anim.queue_free()
	
	
	
