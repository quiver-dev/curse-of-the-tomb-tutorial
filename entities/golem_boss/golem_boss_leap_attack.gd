extends State


@export var number_of_leaps := 5
var leaps_so_far := 0

@export var leap_interval := 1.0
var leap_interval_remaining := 0.0

var is_leaping := false
var golem: Golem


func _enter(previous_state, host):
	golem = host
	leaps_so_far = 0
	leap_interval_remaining = 0
	is_leaping = false

	host.animation_player.animation_finished.connect(_on_animation_finished)

	start_leap()


func _exit(new_state, host):
	host.animation_player.animation_finished.disconnect(_on_animation_finished)
	host.velocity.x = 0


func _execute(delta, host):
	if host.is_on_floor():
		if is_leaping:
			host.animation_player.play("land")
			is_leaping = false
			leap_interval_remaining = leap_interval
		elif leap_interval_remaining <= 0:
			start_leap()

	leap_interval_remaining -= delta


func _get_next_state(host):
	if host.current_health <= 0:
		return host.States.DIE

	if host.current_shield <= 0:
		var state = host.States.VULNERABLE_PHASE_1 if host.phase == 1 else host.States.VULNERABLE_PHASE_2
		return state

	if leaps_so_far == number_of_leaps:
		var state = host.States.IDLE_PHASE_1 if host.phase == 1 else host.States.IDLE_PHASE_2
		return state

	return null


func start_leap():
	golem.face_player()
	golem.animation_player.play("leap")


func _on_animation_finished(anim_name: String):
	match anim_name:
		"leap":
			is_leaping = true
		"land":
			leaps_so_far += 1
			golem.animation_player.play("idle")
