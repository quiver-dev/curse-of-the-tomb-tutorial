extends CharacterBody2D
class_name Entity


signal on_damage_taken(attacker: Node2D)
signal on_health_changed(new_health: int)
signal on_death(entity)

@export var should_play_damage_tween := true
@export var max_health := 1
var current_health := 1

@export var max_shield := 0
var current_shield := 0

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

	if current_shield > 0:
		current_shield -= damage

		if current_shield <= 0:
			current_shield = 0

	current_health -= damage
	on_damage_taken.emit(attacker)
	on_health_changed.emit(current_health)

	if invulnerability_time > 0.0 and current_health > 0:
		invulnerability_time_remaining = invulnerability_time
		play_invulnerability_tween()
	else:
		play_damage_tween()

	if current_health <= 0:
		die()


func restore_health(health: int):
	var previous_health = current_health
	current_health = clampi(current_health + health, current_health, max_health)
	if current_health != previous_health:
		on_health_changed.emit(current_health)


func change_max_health(new_max_health: int):
	max_health = new_max_health
	current_health = max_health
	on_health_changed.emit(current_health)


func play_damage_tween() -> Tween:
	if not should_play_damage_tween:
		return null

	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 0, 0), 0.2)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	return tween


func play_invulnerability_tween() -> Tween:
	if not should_play_damage_tween:
		return null

	var tween = play_damage_tween()
	for i in range(4):
		tween.tween_property(self, "modulate:a", 0.2, 0.1)
		tween.tween_property(self, "modulate:a", 1.0, 0.1)

	return tween


func die():
	is_dead = true
	on_death.emit(self)
