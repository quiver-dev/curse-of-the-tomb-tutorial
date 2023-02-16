extends CharacterBody2D


@export var speed: float = 600.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_velocity: float = -1500
@export var jump_hang_time: float = 0.15

var hang_time_remaining: float = 0.0

@onready var pivot = $Pivot


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		pivot.scale.x = 1
	elif direction < 0:
		pivot.scale.x = -1

	if not is_on_floor():
		if hang_time_remaining > 0:
			velocity.y = jump_velocity
			hang_time_remaining -= delta
		else:
			velocity.y += gravity

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		hang_time_remaining = jump_hang_time

	velocity.x = direction * speed
	move_and_slide()
