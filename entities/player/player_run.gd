extends State


func _enter(previous_state, host):
	host.animation_player.play("run")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.attack():
		return host.States.ATTACK

	if host.throw():
		return host.States.THROW

	if host.is_falling():
		return host.States.FALL

	if host.jump():
		return host.States.JUMP

	if host.dash():
		return host.States.DASH

	if host.knockback():
		return host.States.KNOCKBACK

	if is_zero_approx(host.get_movement_direction()) and is_zero_approx(host.velocity.x):
		return host.States.IDLE

	return null
