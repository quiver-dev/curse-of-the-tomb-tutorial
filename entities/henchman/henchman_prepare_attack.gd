extends State


var prepare_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("prepare_attack")
	host.velocity.x = 0
	prepare_time_remaining = host.prepare_duration


func _exit(new_state, host):
	pass


func _execute(delta, host):
	prepare_time_remaining -= delta


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if prepare_time_remaining <= 0:
		return host.States.ATTACK

	return null
