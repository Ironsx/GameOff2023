extends Node2D

var control_focused : bool = false

@onready var audioStreamSFXPointing = $AudioStreamSFXPointing
@onready var audioStreamSFXClick = $AudioStreamSFXClick
@onready var btn_play = $CanvasLayer/MarginContainer/VBoxContainer/BtnPlay
@onready var btn_settings = $CanvasLayer/MarginContainer/VBoxContainer/BtnSettings
@onready var btn_credits = $CanvasLayer/MarginContainer/VBoxContainer/BtnCredits
@onready var btn_quit = $CanvasLayer/MarginContainer/VBoxContainer/BtnQuit
@onready var lb_version = $CanvasLayer/LbVersion

signal btn_play_pressed
signal btn_options_pressed
signal btn_credits_pressed


func _ready():
	lb_version.text = "Version " + ProjectSettings.get_setting("application/config/version")

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_down"):
		if !control_focused:
			control_focused = true
			btn_play.grab_focus()


func _on_btn_play_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	emit_signal("btn_play_pressed")


func _on_btn_settings_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	emit_signal("btn_options_pressed")


func _on_btn_credits_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	emit_signal("btn_credits_pressed")


func _on_btn_quit_pressed():
	audioStreamSFXClick.play()
	await audioStreamSFXClick.finished
	get_tree().quit()


func _on_btn_play_mouse_entered():
	btn_play.grab_focus()


func _on_btn_settings_mouse_entered():
	btn_settings.grab_focus()


func _on_btn_credits_mouse_entered():
	btn_credits.grab_focus()


func _on_btn_quit_mouse_entered():
	btn_quit.grab_focus()


func _on_btn_play_mouse_exited():
	lb_version.grab_focus()
	control_focused = false


func _on_btn_settings_mouse_exited():
	lb_version.grab_focus()
	control_focused = false


func _on_btn_credits_mouse_exited():
	lb_version.grab_focus()
	control_focused = false


func _on_btn_quit_mouse_exited():
	lb_version.grab_focus()
	control_focused = false


func _on_btn_play_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_settings_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_credits_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_quit_focus_entered():
	audioStreamSFXPointing.play()
