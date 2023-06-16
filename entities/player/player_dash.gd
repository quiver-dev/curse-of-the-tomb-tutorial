extends State


var dash_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("dash")
	dash_time_remaining = host.animation_player.get_animation("dash").length
	host.input_disabled = true
	host.velocity.x = host.dash_speed * host.last_direction
	host.velocity.y = 0
	host.gravity_disabled = true


func _exit(new_state, host):
	host.input_disabled = false
	host.gravity_disabled = false


func _execute(delta, host):
	dash_time_remaining -= delta


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if dash_time_remaining <= 0.0:
		return host.States.IDLE

	if host.knockback():
		return host.States.KNOCKBACK

	return null
