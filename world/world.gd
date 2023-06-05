extends Node2D


func _ready() -> void:
	$HUD.initialize($Player)
	$CollectableManager.initialize($Enemies.get_children())
