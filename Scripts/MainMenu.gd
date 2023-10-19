extends Node2D

signal btn_play_pressed
signal btn_options_pressed
signal btn_credits_pressed


func _on_btn_play_pressed():
	emit_signal("btn_play_pressed")


func _on_btn_options_pressed():
	emit_signal("btn_options_pressed")


func _on_btn_credits_pressed():
	emit_signal("btn_credits_pressed")


func _on_btn_quit_pressed():
	get_tree().quit()
