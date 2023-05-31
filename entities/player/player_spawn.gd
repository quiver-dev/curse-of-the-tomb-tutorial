extends State


var spawn_time_remaining: float


func _enter(previous_state, host: Player):
	host.input_disabled = true
	host.animation_player.play("spawn")
	spawn_time_remaining = host.animation_player.get_animation("spawn").length


func _exit(new_state, host):
	host.input_disabled = false


func _execute(delta, host):
	spawn_time_remaining -= delta


func _get_next_state(host):
	if spawn_time_remaining <= 0.0:
		return host.States.IDLE

	return null
