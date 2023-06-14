extends Entity


@export var should_drop_collectable := true


func die():
	super()
	$Hit.play_at_random_pitch()
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("break")
