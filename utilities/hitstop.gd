extends Node


var hitstop_end_time_ms := 0.0
var is_in_hitstop := false


func _ready() -> void:
	GlobalSignals.hitstop_requested.connect(on_hitstop_requested)


func _process(delta: float) -> void:
	if Time.get_ticks_msec() >= hitstop_end_time_ms and is_in_hitstop:
		is_in_hitstop = false
		Engine.time_scale = 1


func on_hitstop_requested(hitstop_time_ms: float):
	Engine.time_scale = 0
	is_in_hitstop = true
	hitstop_end_time_ms = Time.get_ticks_msec() + hitstop_time_ms
