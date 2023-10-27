extends CanvasLayer

@onready var lb_fps = $PanelContainer/LbFPS

# Called when the node enters the scene tree for the first time.
func _ready():
	lb_fps.text = str(Performance.get_monitor(Performance.TIME_FPS)) + " FPS"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	lb_fps.text = str(Performance.get_monitor(Performance.TIME_FPS)) + " FPS"
