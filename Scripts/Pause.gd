extends CanvasLayer

var control_focused : bool = false

@onready var lb_pause_menu = $Panel/PanelContainer/MarginContainer/VBoxContainer/LbPauseMenu
@onready var audioStreamSFXPointing = $AudioStreamSFXPointing
@onready var audioStreamSFXClick = $AudioStreamSFXClick
@onready var btn_return_game = $Panel/PanelContainer/MarginContainer/VBoxContainer/BtnReturnGame
@onready var btn_options = $Panel/PanelContainer/MarginContainer/VBoxContainer/BtnOptions
@onready var btn_back_menu = $Panel/PanelContainer/MarginContainer/VBoxContainer/BtnBackMenu
@onready var btn_quit_game = $Panel/PanelContainer/MarginContainer/VBoxContainer/BtnQuitGame


func _input(event):
	if event.is_action_pressed("escape"):
		if not get_parent().has_node("Settings"):
			audioStreamSFXClick.play()
			await audioStreamSFXClick.finished
			Game.is_paused = !Game.is_paused
			get_tree().paused = Game.is_paused
			visible = Game.is_paused


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_down"):
		if !control_focused:
			control_focused = true
			btn_return_game.grab_focus()


func _on_btn_return_game_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_return_game_mouse_entered():
	btn_return_game.grab_focus()


func _on_btn_return_game_mouse_exited():
	lb_pause_menu.grab_focus()
	control_focused = false


func _on_btn_options_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_options_mouse_entered():
	btn_options.grab_focus()


func _on_btn_options_mouse_exited():
	lb_pause_menu.grab_focus()
	control_focused = false


func _on_btn_back_menu_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_back_menu_mouse_entered():
	btn_back_menu.grab_focus()


func _on_btn_back_menu_mouse_exited():
	lb_pause_menu.grab_focus()
	control_focused = false


func _on_btn_quit_game_focus_entered():
	audioStreamSFXPointing.play()


func _on_btn_quit_game_mouse_entered():
	btn_quit_game.grab_focus()


func _on_btn_quit_game_mouse_exited():
	lb_pause_menu.grab_focus()
	control_focused = false
