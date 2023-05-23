extends Entity


enum States { PATROL, DIE }

@export var speed: float = 200.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: float = 1

@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var wall_check = $Pivot/WallCheck
@onready var ground_check = $Pivot/GroundCheck


func _ready() -> void:
	super()
	state_machine.add_state(States.PATROL, $StateMachine/Patrol)
	state_machine.add_state(States.DIE, $StateMachine/Die)
	state_machine.initialize(self, States.PATROL)


func _physics_process(delta: float) -> void:
	if wall_check.is_colliding() or not ground_check.is_colliding():
		direction *= -1

	if direction > 0:
		pivot.scale.x = 1
	elif direction < 0:
		pivot.scale.x = -1

	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()


func take_damage(damage: int):
	$Hit.play_at_random_pitch()
	super(damage)
