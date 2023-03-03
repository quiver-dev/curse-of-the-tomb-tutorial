extends CharacterBody2D


enum States { IDLE, RUN, JUMP, FALL }

@export var speed: float = 1000.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_velocity: float = -1500
@export var jump_hang_time: float = 0.15

var hang_time_remaining: float = 0.0

@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine


func _ready() -> void:
	state_machine.add_state(States.IDLE, $StateMachine/Idle)
	state_machine.add_state(States.RUN, $StateMachine/Run)
	state_machine.add_state(States.JUMP, $StateMachine/Jump)
	state_machine.add_state(States.FALL, $StateMachine/Fall)
	state_machine.initialize(self, States.IDLE)


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
			# This is our fall state
			velocity.y += gravity
			if velocity.y > 250.0:
				animation_player.play("fall")

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
			hang_time_remaining = jump_hang_time
			animation_player.play("jump")
		elif velocity.x != 0.0:
			animation_player.play("run")
		else:
			animation_player.play("idle")

	velocity.x = direction * speed
	move_and_slide()
