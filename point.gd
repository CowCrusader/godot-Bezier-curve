extends Node2D

@onready var mouse_detector = $"MouseDetector"
var mouse:bool = false
var hold:bool = false
func _process(delta):
	if Input.is_action_just_pressed("mouse") && mouse:
		hold = true
		
	if Input.is_action_just_released("mouse"):
		hold = false
	
	if hold:
		global_position = get_global_mouse_position()


func _on_area_2d_mouse_entered():
	mouse = true

func _on_area_2d_mouse_exited():
	mouse = false
