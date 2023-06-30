extends Camera2D


@export var base_offset := Vector2(0, -100)
@export var look_ahead_distance := 150
@export var look_ahead_speed := 2.0

var player: Player

var shake_offset := Vector2.ZERO
var shake_strength := 0.0

@onready var shake_timer = $ShakeTimer


func _ready() -> void:
	offset = base_offset
	GlobalSignals.camera_shake_requested.connect(shake)


func shake(duration: float, strength: float):
	shake_timer.start(duration)
	shake_strength = strength


func _process(delta: float) -> void:
	var direction := 0.0
	if player != null and not player.input_disabled:
		direction = player.get_movement_direction()

	if not shake_timer.is_stopped():
		shake_offset = Vector2(
			randf_range(-1, 1) * shake_strength,
			randf_range(-1, 1) * shake_strength
		)
	else:
		shake_offset = shake_offset.lerp(Vector2.ZERO, 0.5)

	var look_ahead_offset = Vector2(direction * look_ahead_distance, 0)
	offset = offset.lerp(base_offset + look_ahead_offset + shake_offset, look_ahead_speed * delta)
