extends AnimatedSprite2D



func _on_animation_looped():
	queue_free()
