extends RigidBody2D
class_name Sword


@export var acceleration := 3.0
@export var throw_force := 1500.0
@export var torque_force := 10000.0

var player: Player = null

@onready var pivot = $Pivot
@onready var hurtbox = $Pivot/Hurtbox


func _physics_process(delta: float) -> void:
	if player == null:
		return

	pivot.scale = player.pivot.scale

	global_position = global_position.lerp(player.sword_position.global_position, delta * acceleration)


func throw():
	player = null
	hurtbox.monitoring = true
	hurtbox.damage_dealt.connect(queue_free)
	apply_impulse(Vector2(pivot.scale.x * throw_force, 0))
	apply_torque_impulse(pivot.scale.x * torque_force)
	$DestroyTimer.start()


func _on_pickup_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_telekinesis and body.sword == null:
			player = body
			player.sword = self


func _on_destroy_timer_timeout() -> void:
	queue_free()
