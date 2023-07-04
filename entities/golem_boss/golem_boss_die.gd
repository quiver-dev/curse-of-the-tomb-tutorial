extends State


var golem: Golem


func _enter(previous_state, host: Golem):
	golem = host
	host.animation_player.animation_finished.connect(_on_animation_finished)
	host.animation_player.play("die")
	host.set_physics_process(false)


func _exit(new_state, host):
	host.animation_player.animation_finished.disconnect(_on_animation_finished)


func _execute(delta, host):
	pass


func _get_next_state(host):
	return null


func _on_animation_finished(anim_name: String):
	match anim_name:
		"die":
			golem.animation_player.play("die_loop")
