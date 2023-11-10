extends Area2D

@export var jump : bool = false
@export var force : float


func _on_body_entered(body):
	if body is Player:
		body.redirection()
		if jump:
			body.jump(force)
