extends RigidBody2D


signal torch_collided(location)

@export var horizontal_force := 750.0
@export var vertical_force := -750.0


func initialize(starting_position: Vector2, direction: float):
	global_position = starting_position

	apply_impulse(Vector2(direction * horizontal_force, vertical_force))


func _on_body_entered(body: Node) -> void:
	torch_collided.emit(global_position)
	queue_free()
