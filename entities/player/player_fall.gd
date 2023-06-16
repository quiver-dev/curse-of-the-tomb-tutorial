extends State


var current_fall_time := 0.0


func _enter(previous_state, host):
	host.animation_player.play("fall")
	current_fall_time = 0


func _exit(new_state, host):
	pass


func _execute(delta, host):
	current_fall_time += delta
	if current_fall_time > host.max_fall_time:
		host.respawn()


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.attack():
		return host.States.ATTACK

	if host.jump():
		return host.States.JUMP

	if host.dash():
		return host.States.DASH

	if host.knockback():
		return host.States.KNOCKBACK

	if host.is_on_floor():
		return host.States.IDLE

	return null
