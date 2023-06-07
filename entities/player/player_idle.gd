extends State


func _enter(previous_state, host):
	host.animation_player.play("idle")
	if previous_state == host.States.FALL:
		host.footstep_sfx.play_at_random_pitch()


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.attack():
		return host.States.ATTACK

	if host.is_falling():
		return host.States.FALL

	if host.jump():
		return host.States.JUMP

	if host.knockback():
		return host.States.KNOCKBACK

	if not is_zero_approx(host.velocity.x):
		return host.States.RUN

	return null
