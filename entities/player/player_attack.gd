extends State


func _enter(previous_state, host):
	host.animation_player.play("attack")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.attack_time_remaining <= 0.0:
		return host.States.IDLE

	return null
