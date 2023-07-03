extends AnimatableBody2D


@export var fall_speed := 1000


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.DOWN * fall_speed * delta)
	if collision != null:
		$AnimationPlayer.play("break")
		set_physics_process(false)
