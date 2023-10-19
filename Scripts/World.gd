extends Node2D

@onready var pause = $Pause

signal back_to_menu


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Sprite2D.rotate(0.1)


func _on_btn_return_game_pressed():
	Game.is_paused = false
	get_tree().paused = false
	pause.visible = false


func _on_btn_options_pressed():
	pass


func _on_btn_back_menu_pressed():
	Game.is_paused = false
	get_tree().paused = false
	emit_signal("back_to_menu", self)


func _on_btn_quit_game_pressed():
	get_tree().quit()
