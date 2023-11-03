extends Node2D

@onready var pause = $Pause
@onready var audioStreamSFXClick = $Pause/AudioStreamSFXClick

const OPTIONS = preload("res://Scenes/UIScenes/Settings.tscn")

signal back_to_menu


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.rotate(5 * delta)


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
