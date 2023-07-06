extends State


var last_animation := "attack_2"


func _enter(previous_state, host):
	var animation = "attack" if last_animation == "attack_2" else "attack_2"
	host.animation_player.play(animation)
	last_animation = animation


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	if host.attack_time_remaining <= 0.0:
		return host.States.IDLE

	if host.dash():
		return host.States.DASH

	if host.knockback():
		return host.States.KNOCKBACK

	return null
