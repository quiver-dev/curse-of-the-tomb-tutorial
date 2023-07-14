extends Node


const SAVE_DIR = "user://saves/"
const SAVE_EXTENSION = ".save"


func _ready() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)


func save_game(save_name: String, save_data: Dictionary):
	var save_path = get_save_path(save_name)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file != null:
		save_file.store_var(save_data)
		print("Game saved!")
	else:
		print("ERROR: could not save %s, error code %d" % [save_name, FileAccess.get_open_error()])


func load_game(save_name: String) -> Dictionary:
	var save_path = get_save_path(save_name)
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	if save_file != null:
		var save_data = save_file.get_var()
		print("Game loaded!")
		return save_data
	else:
		print("ERROR: could not load %s, error code %d" % [save_name, FileAccess.get_open_error()])
		return {}


func delete_game(save_name: String) -> bool:
	var save_path = get_save_path(save_name)
	var result = DirAccess.remove_absolute(save_path)
	if result == OK:
		print("Save %s deleted" % save_name)
		return true
	else:
		print("ERROR: could not delete %s, error code %d" % [save_name, result])
		return false


func get_save_path(save_name: String) -> String:
	return SAVE_DIR + save_name + SAVE_EXTENSION
