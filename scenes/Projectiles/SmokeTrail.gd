extends GPUParticles2D

func reparent_to_root():
	global_position = global_position
	set_emitting(false)
	reparent(get_parent().get_parent())
	$"Destroy Timer".start()


func _on_destroy_timer_timeout():
	queue_free()
