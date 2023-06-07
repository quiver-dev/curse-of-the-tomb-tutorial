extends State


func _enter(previous_state, host):
	host.animation_player.play("knockback")
	host.input_disabled = true
	host.did_get_hit = false
	host.velocity.x = host.knockback_velocity.x * host.hit_direction
	host.velocity.y = host.knockback_velocity.y


func _exit(new_state, host):
	host.input_disabled = false


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.knockback_time_remaining <= 0.0:
		return host.States.IDLE

	return null
