extends CanvasLayer

func _input(event):
	if event.is_action_pressed("escape"):
		Game.is_paused = !Game.is_paused
		get_tree().paused = Game.is_paused
		visible = Game.is_paused
