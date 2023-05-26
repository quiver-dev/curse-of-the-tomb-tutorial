extends CharacterBody2D
class_name Entity


signal on_damage_taken(attacker: Node2D)


@export var max_health := 1
var current_health := 1

@export var invulnerability_time := 0.0
var invulnerability_time_remaining := 0.0

var is_dead := false


func _ready() -> void:
	current_health = max_health


func _physics_process(delta: float) -> void:
	if invulnerability_time_remaining > 0.0:
		invulnerability_time_remaining -= delta


func take_damage(damage: int, attacker: Node2D):
	if is_dead or invulnerability_time_remaining > 0.0:
		return

	current_health -= damage
	on_damage_taken.emit(attacker)

	if invulnerability_time > 0.0 and current_health > 0:
		invulnerability_time_remaining = invulnerability_time
		play_invulnerability_tween()
	else:
		play_damage_tween()

	if current_health <= 0:
		die()


func play_damage_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 0, 0), 0.2)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	return tween


func play_invulnerability_tween() -> Tween:
	var tween = play_damage_tween()
	for i in range(4):
		tween.tween_property(self, "modulate:a", 0.2, 0.1)
		tween.tween_property(self, "modulate:a", 1.0, 0.1)

	return tween


func die():
	is_dead = true
