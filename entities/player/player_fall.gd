extends State


func _enter(previous_state, host):
	host.animation_player.play("fall")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.attack():
		return host.States.ATTACK

	if host.jump():
		return host.States.JUMP

	if host.knockback():
		return host.States.KNOCKBACK

	if host.is_on_floor():
		return host.States.IDLE

	return null
