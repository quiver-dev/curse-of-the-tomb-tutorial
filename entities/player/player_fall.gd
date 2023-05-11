extends State


func _enter(previous_state, host):
	host.animation_player.play("fall")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_on_floor():
		return host.States.IDLE

	return null