extends CanvasLayer


var is_paused := false


func _ready() -> void:
	set_paused(false)


func set_paused(should_pause: bool):
	is_paused = should_pause
	visible = should_pause
	get_tree().paused = should_pause


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(not is_paused)
