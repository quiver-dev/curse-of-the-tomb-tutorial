extends World


var falling_rock = preload("res://entities/golem_boss/falling_rock.tscn")

@onready var projectile_manager = $ProjectileManager
@onready var portal = $Portal

@onready var rock_spawns: Array[Node] = $RockSpawns.get_children()
var current_rock_spawns: Array[Node] = []


func _ready() -> void:
	super()

	var player = $Player
	player.velocity.x = 0
	set_player_input_disabled(true)

	portal.hide()
	portal.is_active = false

	var golem = $GolemBoss
	golem.player = player
	golem.face_player()

	golem.rock_spawned.connect(on_rock_spawned)
	golem.on_death.connect(on_golem_death)

	$HUD.initialize_boss_hud(golem)


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


func on_golem_death(golem):
	portal.show()
	portal.is_active = true
