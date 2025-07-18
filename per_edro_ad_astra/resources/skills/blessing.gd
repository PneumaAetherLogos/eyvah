extends ActiveSkill

@export var frames: SpriteFrames



func effect(tree: SceneTree, t = null) -> void:
	
	var anim: AnimatedSprite2D = AnimatedSprite2D.new()
	anim.sprite_frames = frames
	anim.position = Vector2(t.global_position)
	anim.z_index = 100
	tree.current_scene.add_child(anim)
	t.gain_bonus(value)
	anim.play()
	await anim.animation_finished
	anim.queue_free()
