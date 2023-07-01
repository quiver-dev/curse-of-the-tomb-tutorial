extends World


func _ready() -> void:
	super()

	var golem = $GolemBoss
	golem.player = $Player
	golem.face_player()


func set_player_input_disabled(disabled: bool):
	$Player.input_disabled = disabled
