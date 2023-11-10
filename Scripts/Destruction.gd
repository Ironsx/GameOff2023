extends Node2D

const GRAVITY = 10
const DAMPING = 0.980

var objNode = load("res://Scenes/MainScenes/sprite_2d.tscn")
var frames = 0
var detonation = false
var times := 0


func create_image_parts():
	for n in range(25):
		var part = objNode.instantiate()
		part.set_frame(n)
		add_child(part)
		var x = randi() % 5
		var y = randi() % 5
		part.set_position(Vector2(y + position.x, x + position.y))
		frames += 1


func clear():
	frames = 0
	for n in get_children():
		remove_child(n)


func explosion(delta):
	if detonation:
		for part in get_children():
			if times == 0:
				var dir_up := randi_range(-1000, 0) * 6
				var dir_side := randi_range(-100, 100) * 36
				part.position = (Vector2(dir_side, dir_up) - part.position) * delta
			else:
				var speed_up = part.position.y + (part.position.y / times)
				var speed_side = part.position.x + part.position.x / times
				part.position += Vector2(speed_side, speed_up + GRAVITY * 16) * delta
			if part.get_position().x > 0:
				part.rotate(randf_range(5, 5) * delta)
			else:
				part.rotate(randf_range(-5, -5) * delta)
		times += 1


func _ready():
	create_image_parts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	explosion(delta)


func explote():
	randomize()
	detonation = true


func restart():
	clear()
	create_image_parts()
	times = 0
	detonation = false
