extends Node

@onready var main_menu = $MainMenu
@onready var audio_stream_music = $AudioStreamMusic


func _ready():
	connect_menu_signals()
	audio_stream_music.play()


func loadMenu(scene : Variant):
	scene.queue_free()
	var main_menu_scene : PackedScene = preload("res://Scenes/UIScenes/MainMenu.tscn")
	main_menu = main_menu_scene.instantiate()
	add_child(main_menu)
	connect_menu_signals()
	
	if not audio_stream_music.playing:
		audio_stream_music.play()


func connect_menu_signals():
	main_menu.btn_play_pressed.connect(btn_play_pressed)
	main_menu.btn_options_pressed.connect(btn_options_pressed)
	main_menu.btn_credits_pressed.connect(btn_credits_pressed)


func btn_play_pressed():
	audio_stream_music.stop()
	main_menu.queue_free()
	var play_game_scene : PackedScene = preload("res://Scenes/MainScenes/World.tscn")
	var play_game := play_game_scene.instantiate()
	add_child(play_game)
	play_game.back_to_menu.connect(loadMenu)


func btn_options_pressed():
	main_menu.queue_free()
	var options_scene : PackedScene = preload("res://Scenes/UIScenes/Settings.tscn")
	var options := options_scene.instantiate()
	add_child(options)
	options.options_back.connect(loadMenu)


func btn_credits_pressed():
	main_menu.queue_free()
	var credits_scene : PackedScene = preload("res://Scenes/UIScenes/Credits.tscn")
	var credits := credits_scene.instantiate()
	add_child(credits)
	credits.credits_back.connect(loadMenu)


func _on_audio_stream_music_finished():
	await get_tree().create_timer(10).timeout
	audio_stream_music.play()
