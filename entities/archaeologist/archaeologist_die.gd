extends State


func _enter(previous_state, host):
	host.animation_player.play("die")
	host.set_physics_process(false)


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	return null
