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
	if decision_interval_remaining <= 0:
		return choose_next_state(host)

	return null


func choose_next_state(host: Golem) -> Golem.States:
	var attacks := [
		host.States.LEAP_ATTACK_PHASE_1,
#		host.States.POUND_ATTACK_PHASE_1,
	]

	return attacks.pick_random()
