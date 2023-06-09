extends State


func _enter(previous_state, host):
	host.animation_player.play("idle")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.player != null:
		return host.States.ATTACK

	return null
