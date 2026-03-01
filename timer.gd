extends Control
@onready var timer=$Timer
@onready var text=$Ttext

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text.text=str(int(ceil(timer.time_left)))


func starttimer():
	timer.start()
	text.visible=true


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
