extends RigidBody2D
class_name Sword


@export var acceleration := 3.0

var player: Player = null

@onready var pivot = $Pivot
@onready var hurtbox = $Pivot/Hurtbox


func _physics_process(delta: float) -> void:
	if player == null:
		return

	pivot.scale = player.pivot.scale

	global_position = global_position.lerp(player.sword_position.global_position, delta * acceleration)


func _on_pickup_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_telekinesis and body.sword == null:
			player = body
			player.sword = self
