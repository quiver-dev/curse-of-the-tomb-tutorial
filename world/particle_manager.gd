extends Node


var sand_particles = preload("res://entities/player/sand_particles.tscn")


func initialize(player: Player):
	player.footstep_taken.connect(on_player_footstep_taken)


func on_player_footstep_taken(location: Vector2):
	var sp = sand_particles.instantiate()
	sp.global_position = location
	add_child(sp)
	sp.emitting = true
