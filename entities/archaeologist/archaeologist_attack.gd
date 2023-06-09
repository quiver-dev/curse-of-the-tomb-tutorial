extends State


var attack_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("attack")
	attack_time_remaining = host.animation_player.get_animation("attack").length


func _exit(new_state, host):
	pass


func _execute(delta, host):
	attack_time_remaining -= delta


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if attack_time_remaining <= 0:
		return host.States.IDLE

	return null
