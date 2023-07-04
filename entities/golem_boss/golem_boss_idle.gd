extends State


@export var decision_interval := 0.5

var decision_interval_remaining := 0.0


func _enter(previous_state, host):
	host.animation_player.play("idle")
	decision_interval_remaining = decision_interval


func _exit(new_state, host):
	pass


func _execute(delta, host):
	decision_interval_remaining -= delta


func _get_next_state(host):
	if host.current_health <= 0:
		return host.States.DIE

	if host.current_shield <= 0:
		var state = host.States.VULNERABLE_PHASE_1 if host.phase == 1 else host.States.VULNERABLE_PHASE_2
		return state

	if decision_interval_remaining <= 0:
		return choose_next_state(host)

	return null


func choose_next_state(host: Golem) -> Golem.States:
	var attacks := [
		host.States.LEAP_ATTACK_PHASE_1,
		host.States.POUND_ATTACK_PHASE_1,
	] if host.phase == 1 else [
		host.States.LEAP_ATTACK_PHASE_2,
		host.States.POUND_ATTACK_PHASE_2,
		host.States.LASER_ATTACK_PHASE_2,
	]

	return attacks.pick_random()
