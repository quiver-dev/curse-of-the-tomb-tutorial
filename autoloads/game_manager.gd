extends Node


signal on_coins_changed(new_coin_amount: int)

var starting_world := preload("res://world/world_1.tscn")

var health := 3
var max_health := 3
var coins := 0:
	set(value):
		coins = value
		on_coins_changed.emit(coins)


func change_scene(new_scene: PackedScene):
	get_tree().change_scene_to_packed(new_scene)


func handle_player_respawn_needed():
	health = max_health
	change_scene(starting_world)
