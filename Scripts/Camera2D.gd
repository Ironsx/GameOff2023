extends Camera2D

@export var player : Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion(delta)


func reposition():
	pass


func motion(_delta):
	pass
