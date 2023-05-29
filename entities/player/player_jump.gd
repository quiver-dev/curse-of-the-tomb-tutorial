extends State


func _enter(previous_state, host):
	host.animation_player.play("jump")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	if not Input.is_action_pressed("jump"):
		host.velocity.y += host.jump_deceleration


func _get_next_state(host):
	if host.attack():
		return host.States.ATTACK

	if host.knockback():
		return host.States.KNOCKBACK

	if host.is_falling():
		return host.States.FALL

	return null
