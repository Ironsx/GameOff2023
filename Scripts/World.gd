extends Node2D

@onready var pause = $Pause
@onready var audioStreamSFXClick = $Pause/AudioStreamSFXClick

const OPTIONS = preload("res://Scenes/UIScenes/Settings.tscn")
@onready var player : Player = $Player
@onready var check_point: Marker2D = $Map/CheckPoints/CheckPoint_1
var size_checkpoint : int
var direction_checkpoint : int

signal back_to_menu


func _ready():
	player.player_dead.connect(_on_player_dead)


func _on_btn_return_game_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	Game.is_paused = false
	get_tree().paused = false
	pause.visible = false


func _on_btn_options_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	pause.visible = false
	var options_instance := OPTIONS.instantiate()
	add_child(options_instance)
	options_instance.options_back.connect(backToPause)


func _on_btn_back_menu_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	Game.is_paused = false
	get_tree().paused = false
	emit_signal("back_to_menu", self)


func _on_btn_quit_game_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	get_tree().quit()


func backToPause(_scene):
	pause.visible = true
	get_node("Settings").queue_free()


func _on_player_dead():
	await get_tree().create_timer(2).timeout
	#player.revive(size_checkpoint, direction_checkpoint)
	player.revive(2, 1)
	player.position = check_point.position
