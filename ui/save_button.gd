extends Button


var save_name := ""
var save_data := {}

@onready var delete_button = $DeleteButton


func initialize_button(save_name: String):
	self.save_name = save_name
	save_data = SaveManager.load_game(save_name)

	if save_data.is_empty():
		reset_save_button()
	else:
		delete_button.show()
		var current_world_filepath: String = save_data["current_world"]
		var cw_sliced = current_world_filepath.get_slice("/", 3).get_slice(".", 0)
		var ttp = save_data["total_time_played"]
		text = cw_sliced + "\nTotal Time Played: " + get_time_formatted(ttp)


func get_time_formatted(time_s: float) -> String:
	var t := floori(time_s)
	var hours := floori(t / 3600)
	var minutes := floori(t / 60) % 60
	var seconds := t % 60

	if hours > 0:
		return "%dh %dm %ds" % [hours, minutes, seconds]
	elif minutes > 0:
		return "%dm %ds" % [minutes, seconds]
	else:
		return "%ds" % seconds


func reset_save_button():
	text = "New Save"
	save_data = {}
	delete_button.hide()


func _on_pressed() -> void:
	GameManager.load_game(save_name, save_data)


func _on_delete_button_pressed() -> void:
	var success = SaveManager.delete_game(save_name)
	if success:
		reset_save_button()
