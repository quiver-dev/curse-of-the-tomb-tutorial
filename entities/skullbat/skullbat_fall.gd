extends State


var fall_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("fall")
	fall_time_remaining = host.animation_player.get_animation("fall").length
	host.velocity.y = host.fall_speed
	if host.direction == 1:
		host.pivot.scale.x = -1


func _exit(new_state, host):
	pass


func _execute(delta, host):
	fall_time_remaining -= delta


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if fall_time_remaining <= 0:
		return host.States.FLY

	return null
