extends State


var throw_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("throw")
	throw_time_remaining = host.animation_player.get_animation("throw").length


func _exit(new_state, host):
	pass


func _execute(delta, host):
	throw_time_remaining -= delta


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if throw_time_remaining <= 0:
		return host.States.IDLE

	if host.jump():
		return host.States.JUMP

	if host.dash():
		return host.States.DASH

	if host.knockback():
		return host.States.KNOCKBACK

	return null
