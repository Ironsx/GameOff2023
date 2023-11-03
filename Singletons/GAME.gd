extends Node

const KEY : String = "w2QTiWkuUeFqj0RPeFlZcQpa4UQWRpxm"
const FILE : String = "user://settings.dat"

var master_sound : int = 100
var music_sound : int = 100
var sfx_sound : int = 100
var is_sound : bool = true
var is_music : bool = true
var is_sfx : bool = true
var is_full_screen : bool = false

var is_paused : bool = false

var audio_bus_master : int = AudioServer.get_bus_index("Master")
var audio_bus_music : int = AudioServer.get_bus_index("Music")
var audio_bus_sfx : int = AudioServer.get_bus_index("SFX")


# Called when the node enters the scene tree for the first time.
func _ready():
	var file_decrypted := FileAccess.open_encrypted_with_pass(FILE, FileAccess.READ, KEY)
	
	if file_decrypted == null:
		saveSettingsFile()
		return
	
	var json_as_text = file_decrypted.get_as_text()
	var json_as_dict = JSON.parse_string(json_as_text)
	
	master_sound = json_as_dict["master"]
	music_sound = json_as_dict["music"]
	sfx_sound = json_as_dict["sfx"]
	is_sound = json_as_dict["is_sound"]
	is_music = json_as_dict["is_music"]
	is_sfx = json_as_dict["is_sfx"]
	is_full_screen = json_as_dict["is_full_screen"]
	
	AudioServer.set_bus_volume_db(audio_bus_master, Game.master_sound * log(master_sound / 100.0) / log(10))
	AudioServer.set_bus_volume_db(audio_bus_music, log(music_sound / 100.0) / log(10))
	AudioServer.set_bus_volume_db(audio_bus_sfx, log(sfx_sound / 100.0) / log(10))
	
	if is_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func saveSettings(settings : Dictionary):
	master_sound = settings["master"]
	music_sound = settings["music"]
	sfx_sound = settings["sfx"]
	is_sound = settings["is_sound"]
	is_music = settings["is_music"]
	is_sfx = settings["is_sfx"]
	is_full_screen = settings["is_full_screen"]
	
	AudioServer.set_bus_volume_db(audio_bus_master, log(master_sound / 100.0) / log(10))
	AudioServer.set_bus_volume_db(audio_bus_music, log(music_sound / 100.0) / log(10))
	AudioServer.set_bus_volume_db(audio_bus_sfx, log(sfx_sound / 100.0) / log(10))
	
	saveSettingsFile()


func saveSettingsFile():
	var settings : Dictionary = {}
	settings["master"] = master_sound
	settings["music"] = music_sound
	settings["sfx"] = sfx_sound
	settings["is_sound"] = is_sound
	settings["is_music"] = is_music
	settings["is_sfx"] = is_sfx
	settings["is_full_screen"] = is_full_screen
	
	var json = JSON.stringify(settings)
	var file_encrypted := FileAccess.open_encrypted_with_pass(FILE, FileAccess.WRITE, KEY)
	file_encrypted.store_string(json)
