extends Node


signal on_coins_changed(new_coin_amount: int)

enum Upgrades { EXTRA_HEALTH_1, EXTRA_HEALTH_2, DOUBLE_JUMP, DASH, TELEKINESIS }

var save_name := ""
var total_time_played := 0.0
var is_playing := false
var current_world := "res://world/spawn_room.tscn"

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


func _exit_tree() -> void:
	if not save_name.is_empty():
		SaveManager.save_game(save_name, create_save_data())


func _process(delta: float) -> void:
	if is_playing:
		total_time_played += delta


func load_game(save_name: String, save_data: Dictionary):
	if not save_data.is_empty():
		max_health = save_data["max_health"]
		health = max_health

		coins = save_data["coins"]
		has_extra_health_1 = save_data["has_extra_health_1"]
		has_extra_health_2 = save_data["has_extra_health_2"]
		has_double_jump = save_data["has_double_jump"]
		has_dash = save_data["has_dash"]
		has_telekinesis = save_data["has_telekinesis"]
		total_time_played = save_data["total_time_played"]
		current_world = save_data["current_world"]

	self.save_name = save_name
	is_playing = true
	get_tree().change_scene_to_file(current_world)


func create_save_data() -> Dictionary:
	return {
		"max_health": max_health,
		"coins": coins,
		"has_extra_health_1": has_extra_health_1,
		"has_extra_health_2": has_extra_health_2,
		"has_double_jump": has_double_jump,
		"has_dash": has_dash,
		"has_telekinesis": has_telekinesis,
		"save_name": save_name,
		"total_time_played": total_time_played,
		"current_world": current_world,
	}


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
	current_world = new_scene.resource_path
	get_tree().change_scene_to_packed(new_scene)


func change_scene_to_starting_world():
	change_scene(starting_world)


func handle_player_respawn_needed():
	health = max_health
	change_scene(starting_world)
