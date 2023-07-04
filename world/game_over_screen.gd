extends PanelContainer


func _on_restart_button_pressed() -> void:
	GameManager.change_scene_to_starting_world()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
