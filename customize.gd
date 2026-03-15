extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://title_screen.tscn")


func _on_base_pressed() -> void:
	global.skin=0


func _on_fem_pressed() -> void:
	global.skin=4


func _on_trans_pressed() -> void:
	global.skin=3


func _on_pizza_pressed() -> void:
	global.skin=1


func _on_bible_pressed() -> void:
	global.skin=2
