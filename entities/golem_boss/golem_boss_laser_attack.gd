extends State


@export var lead_in_time := 2.0
var lead_in_time_remaining := 0.0

@export var fire_time := 3.9
var fire_time_remaining := 0.0

var firing := false
var done := false
var golem: Golem


func _enter(previous_state, host: Golem):
	golem = host
	firing = false
	done = false
	host.face_player()
	lead_in_time_remaining = lead_in_time
	fire_time_remaining = fire_time
	host.request_camera_shake(lead_in_time, 400)
	host.laser_animation_player.animation_finished.connect(_on_laser_animation_finished)
	host.animation_player.play("laser_lead_in")


func _exit(new_state, host):
	host.laser_animation_player.animation_finished.disconnect(_on_laser_animation_finished)
	host.laser_animation_player.play("RESET")


func _execute(delta, host):
	if not firing and not done:
		lead_in_time_remaining -= delta
		if lead_in_time_remaining <= 0:
			firing = true
			host.laser_sfx.play_at_random_pitch()
			host.animation_player.play("laser_fire")
			host.laser_animation_player.play("fire_start")
			host.request_camera_shake(fire_time, 650)
	elif firing:
		fire_time_remaining -= delta
		if fire_time_remaining <= 0 and host.laser_animation_player.current_animation == "fire_loop":
			host.animation_player.play("laser_lead_out")
			host.laser_animation_player.play("fire_stop")


func _get_next_state(host):
	if host.current_health <= 0:
		return host.States.DIE

	if host.current_shield <= 0:
		var state = host.States.VULNERABLE_PHASE_1 if host.phase == 1 else host.States.VULNERABLE_PHASE_2
		return state

	if done:
		var state = host.States.IDLE_PHASE_1 if host.phase == 1 else host.States.IDLE_PHASE_2
		return state

	return null


func _on_laser_animation_finished(anim_name: String):
	match anim_name:
		"fire_start":
			golem.laser_animation_player.play("fire_loop")
		"fire_stop":
			done = true
			golem.laser_animation_player.play("RESET")
