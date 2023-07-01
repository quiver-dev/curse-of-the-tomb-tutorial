extends Node2D
class_name World


func _ready() -> void:
	var player = $Player

	player.max_health = GameManager.max_health
	player.current_health = GameManager.health
	player.has_double_jump = GameManager.has_double_jump
	player.has_dash = GameManager.has_dash
	player.has_telekinesis = GameManager.has_telekinesis

	player.on_health_changed.connect(handle_player_health_changed)
	player.respawn_needed.connect(GameManager.handle_player_respawn_needed)

	$HUD.initialize(player)

	var enemies = $Enemies.get_children()
	var breakables = $Breakables.get_children()
	$CollectableManager.initialize(enemies, breakables)
	$ProjectileManager.initialize(enemies)


func handle_player_health_changed(new_health: int):
	GameManager.health = new_health
