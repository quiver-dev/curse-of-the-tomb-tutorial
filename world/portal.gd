extends Area2D


@export var is_active := true
@export var next_level: PackedScene


func _on_body_entered(body: Node2D) -> void:
	if is_active and next_level != null and body is Player:
		GameManager.change_scene(next_level)
