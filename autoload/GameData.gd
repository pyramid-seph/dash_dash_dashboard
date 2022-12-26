extends Node


const SAVE_GAME_PATH: String = "user://game_data.json"
const VERSION: int = 1


var hi_score: int = 0


func _init() -> void:
	_load()


func file_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func ensure_file_exist() -> void:
	if not file_exists(): save()


func _load() -> void:
	ensure_file_exist()
	
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if not file:
		var error = FileAccess.get_open_error()
		print("Error while accesing save data: %s" % error)
		return
	
	var json_string := file.get_as_text()
	var data = JSON.parse_string(json_string)
	hi_score = data.hi_score


func save() -> void:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if not file:
		var error = FileAccess.get_open_error()
		print("Error while accesing save data: %s" % error)
		return
	
	var data := {
		"version": VERSION,
		"hi_score": hi_score,
	}
	
	var json_string := JSON.stringify(data)
	file.store_string(json_string)
