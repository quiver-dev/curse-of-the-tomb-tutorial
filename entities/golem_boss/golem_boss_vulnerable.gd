extends State


@export var vulnerable_time := 2.0
var vulnerable_time_remaining := 0.0

var golem: Golem


func _enter(previous_state, host: Golem):
	golem = host
	vulnerable_time_remaining = vulnerable_time

	host.animation_player.animation_finished.connect(_on_animation_finished)
	host.animation_player.play("vulnerable_lead_in")


func _exit(new_state, host):
	host.animation_player.animation_finished.disconnect(_on_animation_finished)
	host.reset_shield()


func _execute(delta, host):
	vulnerable_time_remaining -= delta


func _get_next_state(host):
	if host.current_health <= 0:
		return host.States.DIE

	if vulnerable_time_remaining <= 0:
		var state = host.States.IDLE_PHASE_1 if host.phase == 1 else host.States.IDLE_PHASE_2
		return state

	return null


func _on_animation_finished(anim_name: String):
	match anim_name:
		"vulnerable_lead_in":
			golem.animation_player.play("vulnerable_loop")
