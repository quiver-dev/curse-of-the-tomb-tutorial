extends Entity


enum States { IDLE, RUN, JUMP, FALL, ATTACK, KNOCKBACK }

@export var speed: float = 1500.0
@export var acceleration := 150.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_velocity: float = -2500
@export var jump_deceleration := 200.0
@export var knockback_velocity := Vector2(1500, -1500)

@export var knockback_time := 0.2
var knockback_time_remaining := 0.0

@export var jump_hang_time: float = 0.2
var hang_time_remaining: float = 0.0

@export var jump_input_buffer: float = 0.15
var input_buffer_remaining: float = 0.0

@export var attack_time: float = 0.25
var attack_time_remaining: float = 0.0

var input_disabled := false
var did_get_hit := false
var hit_direction := 1
var jumps_remaining := 1

@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var footstep_sfx = $Sounds/Footstep


func _ready() -> void:
	super._ready()
	state_machine.add_state(States.IDLE, $StateMachine/Idle)
	state_machine.add_state(States.RUN, $StateMachine/Run)
	state_machine.add_state(States.JUMP, $StateMachine/Jump)
	state_machine.add_state(States.FALL, $StateMachine/Fall)
	state_machine.add_state(States.ATTACK, $StateMachine/Attack)
	state_machine.add_state(States.KNOCKBACK, $StateMachine/Knockback)
	state_machine.initialize(self, States.IDLE)
	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)

	if not input_disabled:
		var direction = get_movement_direction()

		if direction > 0:
			pivot.scale.x = 1
		elif direction < 0:
			pivot.scale.x = -1

		velocity.x = move_toward(velocity.x, direction * speed, acceleration)

	if not is_on_floor():
		if hang_time_remaining > 0:
			hang_time_remaining -= delta
		else:
			# This is our fall state
			velocity.y += gravity
	elif not [States.JUMP, States.FALL].has(state_machine.current_state):
		jumps_remaining = 1

	if input_buffer_remaining > 0.0:
		input_buffer_remaining -= delta

	if attack_time_remaining > 0.0:
		attack_time_remaining -= delta

	if knockback_time_remaining > 0.0:
		knockback_time_remaining -= delta

	move_and_slide()


func jump() -> bool:
	if input_buffer_remaining > 0.0 and jumps_remaining > 0:
		velocity.y = jump_velocity
		hang_time_remaining = jump_hang_time
		jumps_remaining -= 1
		return true
	return false


func is_falling() -> bool:
	return velocity.y > 250.0


func attack() -> bool:
	if not input_disabled and Input.is_action_just_pressed("attack") and attack_time_remaining <= 0.0:
		attack_time_remaining = attack_time
		return true
	return false


func knockback() -> bool:
	if did_get_hit:
		knockback_time_remaining = knockback_time
		return true
	return false


func get_movement_direction() -> float:
	return Input.get_axis("move_left", "move_right")


func _on_damage_taken(attacker: Node2D):
	did_get_hit = true
	var direction_to_attacker := attacker.global_position.direction_to(global_position)
	hit_direction = -1 if direction_to_attacker.x < 0 else 1


func _unhandled_input(event: InputEvent) -> void:
	if not input_disabled and event.is_action_pressed("jump"):
		input_buffer_remaining = jump_input_buffer
