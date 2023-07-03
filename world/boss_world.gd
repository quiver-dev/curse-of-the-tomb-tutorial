extends World


var falling_rock = preload("res://entities/golem_boss/falling_rock.tscn")

@onready var projectile_manager = $ProjectileManager
@onready var rock_spawns: Array[Node] = $RockSpawns.get_children()
var current_rock_spawns: Array[Node] = []


func _ready() -> void:
	super()

	var golem = $GolemBoss
	golem.player = $Player
	golem.face_player()

	golem.rock_spawned.connect(on_rock_spawned)


func set_player_input_disabled(disabled: bool):
	$Player.input_disabled = disabled


func on_rock_spawned():
	if current_rock_spawns.size() == 0:
		current_rock_spawns = rock_spawns.duplicate()
		current_rock_spawns.shuffle()

	var spawn_point = current_rock_spawns.pop_back()
	var rock = falling_rock.instantiate()
	rock.global_position = spawn_point.global_position
	projectile_manager.add_child(rock)
