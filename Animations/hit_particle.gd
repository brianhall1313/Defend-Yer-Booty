extends CPUParticles2D


func play_animation():
	emitting=true


func _on_finished():
	queue_free()
