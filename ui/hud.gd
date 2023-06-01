extends CanvasLayer


var heart_sprite = preload("res://ui/heart_sprite.tscn")

@onready var heart_area = %HeartArea


func initialize(player: Player):
	player.on_health_changed.connect(handle_player_health_changed)


func set_health_sprites(new_health: int):
	for child in heart_area.get_children():
		child.queue_free()

	for i in range(new_health):
		heart_area.add_child(heart_sprite.instantiate())


func handle_player_health_changed(new_health: int):
	set_health_sprites(new_health)
