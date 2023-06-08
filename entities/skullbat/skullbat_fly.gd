extends State


var fly_time_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("fly")
	host.velocity.y = 0
	host.velocity.x = host.fly_speed * host.direction
	fly_time_remaining = host.max_fly_time


func _exit(new_state, host):
	pass


func _execute(delta, host):
	fly_time_remaining -= delta
	if fly_time_remaining <= 0:
		host.queue_free()


func _get_next_state(host):
	if host.is_dead:
		return host.States.DIE

	return null
