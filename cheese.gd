extends Node2D

var collected = false
@onready var player = $"../CharacterBody2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if collected:
		position=position.lerp(player.position,5*delta)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if not collected:
		$"../CanvasLayer/UI".starttimer()
		$"../AudioStreamPlayer".stream=load("res://music/OVERTIME_!.mp3")
		$"../AudioStreamPlayer".volume_db=-10
		$"../AudioStreamPlayer".play()
	collected = true
	
