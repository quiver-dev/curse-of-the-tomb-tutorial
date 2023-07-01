extends Entity


enum States { IDLE, FALL, FLY, DIE }

@export var fly_speed := 100.0
@export var fall_speed := 100.0
@export var max_fly_time := 5.0

var direction := 0.0

@onready var state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer
@onready var pivot = $Pivot


func _ready() -> void:
	super()

	state_machine.add_state(States.IDLE, $StateMachine/Idle)
	state_machine.add_state(States.FALL, $StateMachine/Fall)
	state_machine.add_state(States.FLY, $StateMachine/Fly)
	state_machine.add_state(States.DIE, $StateMachine/Die)
	state_machine.initialize(self, States.IDLE)

	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)

	move_and_slide()


func _on_damage_taken(attacker: Node2D):
	$Hit.play_at_random_pitch()


func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body is Player and is_zero_approx(direction):
		var direction_to_player = global_position.direction_to(body.global_position)
		direction = -1 if direction_to_player.x < 0 else 1
