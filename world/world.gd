extends Node2D


func _ready() -> void:
	$HUD.initialize($Player)
	$HUD.set_health_sprites($Player.current_health)
