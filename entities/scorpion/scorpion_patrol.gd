extends State


func _enter(previous_state, host):
	host.animation_player.play("walk")


func _exit(new_state, host):
	pass


func _execute(delta, host):
	pass


func _get_next_state(host):
	return null
