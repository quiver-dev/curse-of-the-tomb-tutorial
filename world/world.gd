extends Node2D


func _ready() -> void:
	var player = $Player

	player.max_health = GameManager.max_health
	player.current_health = GameManager.health

	player.on_health_changed.connect(handle_player_health_changed)

	$HUD.initialize(player)
	$CollectableManager.initialize($Enemies.get_children())


func handle_player_health_changed(new_health: int):
	GameManager.health = new_health
