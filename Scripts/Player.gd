extends CharacterBody2D
class_name Player

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var destruction = $Destruction


const SPEED : float = 500.0
const JUMP_VELOCITY : float = 500.0
const ROTATION_SPEED : int = 10
const ROTATION_SPEED_SMALL : int = 16

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : int = 1
var size : int = 2
var is_ready : bool = false

signal player_dead


func _physics_process(delta):
	if size == 2:
		sprite_2d.rotate(ROTATION_SPEED * direction * delta)
	else:
		sprite_2d.rotate(ROTATION_SPEED_SMALL * direction * delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		jump()
	
	if Input.is_action_just_pressed("resize"):
		resizing()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = direction * SPEED
	
	var collide : bool = move_and_slide()
	if collide and not is_on_floor():
		dead()


func dead():
	direction = 0
	set_physics_process(false)
	sprite_2d.visible = false
	destruction.explote()
	emit_signal("player_dead")


func revive(_size : int, _direction : int):
	direction = _direction
	if size != _size:
		resizing()
	sprite_2d.set_deferred("shader_parameter/progress", 0)
	sprite_2d.visible = true
	destruction.restart()
	set_physics_process(true)


func jump(force : float = JUMP_VELOCITY):
	velocity.y = -force * size


func redirection():
	if direction == 1:
		direction = -1
	else:
		direction = 1


func resizing():
	if size == 2:
		size = 1
		animation_player.play("resize")
	else:
		size = 2
		animation_player.play_backwards("resize")
