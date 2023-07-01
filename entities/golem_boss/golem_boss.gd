extends Entity
class_name Golem


enum States {
	IDLE_PHASE_1,
	LEAP_ATTACK_PHASE_1,
	POUND_ATTACK_PHASE_1,
	VULNERABLE_PHASE_1
	}

@export var speed: float = 750.0
@export var gravity: float = 500
@export var jump_velocity: float = -7500

var player: Player = null

@onready var state_machine = $StateMachine
@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	super()
	state_machine.add_state(States.IDLE_PHASE_1, $StateMachine/IdlePhase1)
	state_machine.add_state(States.LEAP_ATTACK_PHASE_1, $StateMachine/LeapAttackPhase1)
	state_machine.add_state(States.POUND_ATTACK_PHASE_1, $StateMachine/PoundAttackPhase1)
	state_machine.add_state(States.VULNERABLE_PHASE_1, $StateMachine/VulnerablePhase1)
	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)
	velocity.y += gravity
	move_and_slide()


func leap():
	velocity.x = speed * pivot.scale.x
	velocity.y = jump_velocity


func land():
	velocity.x = 0


func initialize_state_machine():
	state_machine.initialize(self, States.IDLE_PHASE_1)


func play_spawn_animation():
	animation_player.play("spawn")


func request_camera_shake(duration: float, strength: float):
	GlobalSignals.camera_shake_requested.emit(duration, strength)


func face_player():
	if player != null:
		var direction_to_player = global_position.direction_to(player.global_position)
		var direction = -1 if direction_to_player.x < 0 else 1

		if direction > 0:
			pivot.scale.x = 1
		elif direction < 0:
			pivot.scale.x = -1


func _on_damage_taken(attacker: Node2D):
	$Hit.play_at_random_pitch()
