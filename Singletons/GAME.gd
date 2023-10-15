extends Node

const KEY : String = "w2QTiWkuUeFqj0RPeFlZcQpa4UQWRpxm"
var music : int = 10
var sfx : int = 10
var is_music : bool = true
var is_sfx : bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = "res://settings.txt"
	var json_as_text = FileAccess.open_encrypted(file, FileAccess.READ, KEY.hex_decode())
	
	if json_as_text == null:
		createSettingsFile()
		return
	
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		print(json_as_dict)

func createSettingsFile():
	var settings : Dictionary = {}
	settings["music"] = music
	settings["sfx"] = sfx
	settings["is_music"] = is_music
	settings["is_sfx"] = is_sfx
	
	var json = JSON.stringify(settings)
	var file = "res://settings.txt"
	var json_as_text = FileAccess.open_encrypted(file, FileAccess.WRITE, KEY.hex_decode())
	
