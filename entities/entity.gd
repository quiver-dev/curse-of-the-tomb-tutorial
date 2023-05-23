extends CharacterBody2D
class_name Entity


@export var max_health := 1
var current_health := 1

var is_dead := false


func _ready() -> void:
	current_health = max_health


func take_damage(damage: int):
	if is_dead:
		return

	current_health -= damage

	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 0, 0), 0.2)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)

	if current_health <= 0:
		die()


func die():
	is_dead = true
