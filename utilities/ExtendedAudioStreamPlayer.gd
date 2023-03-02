extends AudioStreamPlayer


@export var pitch_jitter := 0.1

@onready var original_pitch := pitch_scale


func play_at_random_pitch() -> void:
	var new_pitch = original_pitch + [-pitch_jitter, 0, pitch_jitter].pick_random()
	pitch_scale = new_pitch
	play()
