extends State


@export var number_of_pounds := 5
var pounds_so_far := 0

var golem: Golem


func _enter(previous_state, host: Golem):
	golem = host
	pounds_so_far = 0

	host.animation_player.animation_finished.connect(_on_animation_finished)

	host.face_player()
	host.animation_player.play("pound")


func _exit(new_state, host):
	host.animation_player.animation_finished.disconnect(_on_animation_finished)


func _execute(delta, host):
	pass


func _get_next_state(host):
	if host.current_health <= 0:
		return host.States.DIE

	if host.current_shield <= 0:
		var state = host.States.VULNERABLE_PHASE_1 if host.phase == 1 else host.States.VULNERABLE_PHASE_2
		return state

	if pounds_so_far == number_of_pounds:
		var state = host.States.IDLE_PHASE_1 if host.phase == 1 else host.States.IDLE_PHASE_2
		return state

	return null


func _on_animation_finished(anim_name: String):
	match anim_name:
		"pound":
			pounds_so_far += 1
			if pounds_so_far < number_of_pounds:
				golem.animation_player.play("pound")
