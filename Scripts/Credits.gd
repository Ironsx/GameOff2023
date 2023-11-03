extends CanvasLayer

@onready var audio_stream_sfx_pointing = $AudioStreamSFXPointing
@onready var audio_stream_sfx_click = $AudioStreamSFXClick

signal credits_back

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_btn_back_pressed():
	audio_stream_sfx_click.play()
	await audio_stream_sfx_click.finished
	emit_signal("credits_back", self)
