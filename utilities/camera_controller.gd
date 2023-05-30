extends Camera2D


@export var base_offset := Vector2(0, -100)
@export var look_ahead_distance := 150
@export var look_ahead_speed := 2.0

var player: Player


func _ready() -> void:
	offset = base_offset


func _process(delta: float) -> void:
	var direction := 0.0
	if player != null:
		direction = player.get_movement_direction()

	var look_ahead_offset = Vector2(direction * look_ahead_distance, 0)
	offset = offset.lerp(base_offset + look_ahead_offset, look_ahead_speed * delta)
