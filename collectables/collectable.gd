extends Area2D


enum Action { GIVE_HEALTH, GIVE_COIN }

@export var attraction_speed := 50.0
@export var action: Action = Action.GIVE_HEALTH
@export var action_amount: int = 1

var player: Player
var has_been_collected := false


func _physics_process(delta: float) -> void:
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		global_position += direction * attraction_speed


func collect():
	has_been_collected = true

	hide()
	$Collect.play_at_random_pitch()
	$DestroyTimer.start()

	match action:
		Action.GIVE_HEALTH:
			player.restore_health(action_amount)
		Action.GIVE_COIN:
			GameManager.coins += action_amount


func _on_attraction_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_body_entered(body: Node2D) -> void:
	if body == player and not has_been_collected:
		collect()


func _on_destroy_timer_timeout() -> void:
	queue_free()


func _on_collect_timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AttractionZone/CollisionShape2D.disabled = false
