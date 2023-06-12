extends State


func _enter(previous_state, host):
	host.animation_player.play("walk")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	host.velocity.x = host.direction * host.speed


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.player == null:
		return host.States.IDLE

	if host.should_attack_player():
		return host.States.PREPARE_ATTACK

	return null
