extends Node

const KEY : String = "w2QTiWkuUeFqj0RPeFlZcQpa4UQWRpxm"
const FILE : String = "user://settings.dat"

var music : int = 10
var sfx : int = 10
var is_music : bool = true
var is_sfx : bool = true

var is_paused : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var file_decrypted := FileAccess.open_encrypted_with_pass(FILE, FileAccess.READ, KEY)
	
	if file_decrypted == null:
		saveSettingsFile()
		return
	
	var json_as_text = file_decrypted.get_as_text()
	var json_as_dict = JSON.parse_string(json_as_text)
	
	music = json_as_dict["music"]
	sfx = json_as_dict["sfx"]
	is_music = json_as_dict["is_music"]
	is_sfx = json_as_dict["is_sfx"]


func saveSettings(settings : Dictionary):
	music = settings["music"]
	sfx = settings["sfx"]
	is_music = settings["is_music"]
	is_sfx = settings["is_sfx"]
	saveSettingsFile()


func saveSettingsFile():
	var settings : Dictionary = {}
	settings["music"] = music
	settings["sfx"] = sfx
	settings["is_music"] = is_music
	settings["is_sfx"] = is_sfx
	
	var json = JSON.stringify(settings)
	var file_encrypted := FileAccess.open_encrypted_with_pass(FILE, FileAccess.WRITE, KEY)
	file_encrypted.store_string(json)
