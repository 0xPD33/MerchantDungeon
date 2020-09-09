extends Camera2D

var zoomed_in = false

var standard_zoom = Vector2(1.0, 1.0)
var player_move_zoom = Vector2(1.05, 1.05)

var camera_speed = 0.15


func _ready():
	zoom = standard_zoom


func _physics_process(delta):
	if get_parent().sprinting:
		zoom = zoom.move_toward(player_move_zoom, camera_speed * delta)
		if zoom == player_move_zoom:
			zoomed_in = true
	else:
		zoom = zoom.move_toward(standard_zoom, camera_speed * delta)
		if zoom == standard_zoom:
			zoomed_in = false

