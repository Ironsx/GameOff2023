extends CanvasLayer

@onready var lb_master_value = $MarginContainer/VBoxContainer/GridContainer/LbMasterValue
@onready var lb_music_value = $MarginContainer/VBoxContainer/GridContainer/LbMusicValue
@onready var lb_sfx_value = $MarginContainer/VBoxContainer/GridContainer/LbSFXValue
@onready var btn_down_master = $MarginContainer/VBoxContainer/GridContainer/BtnDownMaster
@onready var btn_up_master = $MarginContainer/VBoxContainer/GridContainer/BtnUpMaster
@onready var btn_down_music = $MarginContainer/VBoxContainer/GridContainer/BtnDownMusic
@onready var btn_up_music = $MarginContainer/VBoxContainer/GridContainer/BtnUpMusic
@onready var btn_down_sfx = $MarginContainer/VBoxContainer/GridContainer/BtnDownSFX
@onready var btn_up_sfx = $MarginContainer/VBoxContainer/GridContainer/BtnUpSFX
@onready var cb_master_volume = $MarginContainer/VBoxContainer/GridContainer/CBMasterVolume
@onready var cb_music_volume = $MarginContainer/VBoxContainer/GridContainer/CBMusicVolume
@onready var cb_sfx_volume = $MarginContainer/VBoxContainer/GridContainer/CBSFXVolume
@onready var cb_full_screen = $MarginContainer/VBoxContainer/GridContainer/CBFullScreen

signal options_back


# Called when the node enters the scene tree for the first time.
func _ready():
	cb_master_volume.button_pressed = Game.is_sound
	cb_music_volume.button_pressed = Game.is_music
	cb_sfx_volume.button_pressed = Game.is_sfx
	cb_full_screen.button_pressed = Game.is_full_screen
	
	lb_master_value.text = str(Game.master_sound) + "%"
	lb_music_value.text = str(Game.music_sound) + "%"
	lb_sfx_value.text = str(Game.sfx_sound) + "%"
	updateControls()


func updateControls():
	if Game.master_sound == 0:
		btn_down_master.disabled = true
	elif Game.master_sound == 100:
		btn_up_master.disabled = true
	else:
		btn_down_master.disabled = false
		btn_up_master.disabled = false
	
	if Game.music_sound == 0:
		btn_down_music.disabled = true
	elif Game.music_sound == 100:
		btn_up_music.disabled = true
	else:
		btn_down_music.disabled = false
		btn_up_music.disabled = false
	
	if Game.sfx_sound == 0:
		btn_down_sfx.disabled = true
	elif Game.sfx_sound == 100:
		btn_up_sfx.disabled = true
	else:
		btn_down_sfx.disabled = false
		btn_up_sfx.disabled = false


func _input(event):
	if event.is_action_pressed("escape"):
		save_and_exit()


func save_and_exit():
	Game.saveSettingsFile()
	emit_signal("options_back", self)


func _on_btn_back_pressed():
	save_and_exit()


func _on_btn_down_master_pressed():
	Game.master_sound -= 10
	lb_master_value.text = str(Game.master_sound) + "%"
	var audio_bus_master : int = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(audio_bus_master, Game.master_sound * log(Game.master_sound / 100.0) / log(10))
	updateControls()


func _on_btn_up_master_pressed():
	Game.master_sound += 10
	lb_master_value.text = str(Game.master_sound) + "%"
	var audio_bus_master : int = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(audio_bus_master, Game.master_sound * log(Game.master_sound / 100.0) / log(10))
	updateControls()


func _on_btn_down_music_pressed():
	Game.music_sound -= 10
	lb_music_value.text = str(Game.music_sound) + "%"
	var audio_bus_music : int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(audio_bus_music, Game.music_sound * log(Game.music_sound / 100.0) / log(10))
	updateControls()


func _on_btn_up_music_pressed():
	Game.music_sound += 10
	lb_music_value.text = str(Game.music_sound) + "%"
	var audio_bus_music : int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(audio_bus_music, Game.music_sound * log(Game.music_sound / 100.0) / log(10))
	updateControls()


func _on_btn_down_sfx_pressed():
	Game.sfx_sound -= 10
	lb_sfx_value.text = str(Game.sfx_sound) + "%"
	var audio_bus_sfx : int = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(audio_bus_sfx, Game.sfx_sound * log(Game.sfx_sound / 100.0) / log(10))
	updateControls()


func _on_btn_up_sfx_pressed():
	Game.sfx_sound += 10
	lb_sfx_value.text = str(Game.sfx_sound) + "%"
	var audio_bus_sfx : int = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(audio_bus_sfx, Game.sfx_sound * log(Game.sfx_sound / 100.0) / log(10))
	updateControls()
