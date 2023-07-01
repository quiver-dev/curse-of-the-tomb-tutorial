extends Entity


enum States { IDLE_PHASE_1 }

var player: Player = null

@onready var state_machine = $StateMachine
@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	state_machine.add_state(States.IDLE_PHASE_1, $StateMachine/IdlePhase1)
	on_damage_taken.connect(_on_damage_taken)


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
