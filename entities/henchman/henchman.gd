extends Entity


enum States { IDLE, CHASE, PREPARE_ATTACK, ATTACK, DIE }

@export var speed := 800.0
@export var attack_range := 300.0
@export var prepare_duration := 0.75
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: float = 1
var player: Player

@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine


func _ready():
	super()
	state_machine.add_state(States.IDLE, $StateMachine/Idle)
	state_machine.add_state(States.CHASE, $StateMachine/Chase)
	state_machine.add_state(States.PREPARE_ATTACK, $StateMachine/PrepareAttack)
	state_machine.add_state(States.ATTACK, $StateMachine/Attack)
	state_machine.add_state(States.DIE, $StateMachine/Die)
	state_machine.initialize(self, States.IDLE)
	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)

	if player != null:
		var direction_to_player = global_position.direction_to(player.global_position)
		direction = -1 if direction_to_player.x < 0 else 1

	if direction > 0:
		pivot.scale.x = 1
	elif direction < 0:
		pivot.scale.x = -1

	velocity.y += gravity
	move_and_slide()


func should_attack_player() -> bool:
	if player == null:
		return false

	var distance_to_player = global_position.distance_to(player.global_position)
	return distance_to_player <= attack_range


func _on_damage_taken(attacker: Node2D):
	$Hit.play_at_random_pitch()


func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
