extends Node


signal on_coins_changed(new_coin_amount: int)

enum Upgrades { EXTRA_HEALTH_1, EXTRA_HEALTH_2, DOUBLE_JUMP, DASH, TELEKINESIS }

var has_extra_health_1 := false
var has_extra_health_2 := false
var has_double_jump := false
var has_dash := false
var has_telekinesis := false

var starting_world := preload("res://world/spawn_room.tscn")

var health := 3
var max_health := 3
var coins := 0:
	set(value):
		coins = value
		on_coins_changed.emit(coins)


func has_upgrade(upgrade: Upgrades) -> bool:
	match upgrade:
		Upgrades.EXTRA_HEALTH_1:
			return has_extra_health_1
		Upgrades.EXTRA_HEALTH_2:
			return has_extra_health_2
		Upgrades.DOUBLE_JUMP:
			return has_double_jump
		Upgrades.DASH:
			return has_dash
		Upgrades.TELEKINESIS:
			return has_telekinesis
		_:
			return false


func buy_upgrade(upgrade: Upgrades, cost: int, player: Player) -> bool:
	if coins < cost:
		return false

	coins -= cost

	match upgrade:
		Upgrades.EXTRA_HEALTH_1:
			has_extra_health_1 = true

			max_health += 1
			health = max_health

			player.change_max_health(max_health)
		Upgrades.EXTRA_HEALTH_2:
			has_extra_health_2 = true

			max_health += 1
			health = max_health

			player.change_max_health(max_health)
		Upgrades.DOUBLE_JUMP:
			has_double_jump = true
			player.has_double_jump = true
		Upgrades.DASH:
			has_dash = true
			player.has_dash = true
		Upgrades.TELEKINESIS:
			has_telekinesis = true
			player.has_telekinesis = true

	return true


func change_scene(new_scene: PackedScene):
	get_tree().change_scene_to_packed(new_scene)


func handle_player_respawn_needed():
	health = max_health
	change_scene(starting_world)
