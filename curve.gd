extends Node2D


var point = preload("res://point.tscn")

var points = []
var positions: PackedVector2Array

func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
	# Convert the array of floats into a PackedVector2Array.
	var array : PackedVector2Array = []
	for coord in coords:
		array.append(Vector2(coord[0], coord[1]))
	return array




var line:PackedVector2Array	

func reset():

	while points.size() > 0:
		remove_child(get_child(2))
		points.remove_at(0)
		
	
func _draw():
	draw_polyline(curve, Color.WHEAT, 2., true)
	if not fade:
		draw_polyline(line, Color.CORAL, 1., true)


var curve:PackedVector2Array

func make_curve():

	var curve_cords:PackedVector2Array	
	for p in range(2,points.size(),2):
		for i in Vector3(0, 1, .01):
			var cords = (((1-i)**2) * positions[p-2]) + (((1-i)*2) * i * positions[p-1] ) + ((i**2) * positions[p] )
			curve_cords.append(cords)
	curve = float_array_to_Vector2Array(curve_cords)
	
var fade = false
var node_fade = false

func _process(delta):
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("fade"):
		if fade == true:
			fade = false
		else:
			fade = true
	
	if Input.is_action_just_pressed("node_fade"):
		if node_fade==true:
			node_fade=false
			for poi in points:
				poi.visible = true
				
		else:
			node_fade=true

	if node_fade:
		for poi in points:
			poi.visible = false
			
			
	if Input.is_action_just_pressed("add"):
		var adding = point.instantiate()
		add_child(adding)
		adding.global_position = get_global_mouse_position()
		points.append(adding)
		
	
	if Input.is_action_just_pressed("reset"):
		reset()
	
	positions = []
	for i in points:
		positions.append(i.global_position)
	
	line = float_array_to_Vector2Array(positions)

	make_curve()

	queue_redraw()
