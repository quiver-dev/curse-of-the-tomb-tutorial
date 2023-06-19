extends State


func _enter(previous_state, host):
	if host.has_double_jump and host.jumps_remaining == 0:
		host.animation_player.play("double_jump")
	else:
		host.animation_player.play("jump")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	if not Input.is_action_pressed("jump"):
		host.velocity.y += host.jump_deceleration


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.attack():
		return host.States.ATTACK

	if host.throw():
		return host.States.THROW

	if host.jump():
		return host.States.JUMP

	if host.dash():
		return host.States.DASH

	if host.knockback():
		return host.States.KNOCKBACK

	if host.is_falling():
		return host.States.FALL

	return null
