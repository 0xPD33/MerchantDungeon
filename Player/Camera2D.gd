extends Camera2D

var standard_zoom = Vector2(1.0, 1.0)
var player_move_zoom = Vector2(1.05, 1.05)

var camera_speed = 0.2


func _ready():
	zoom = standard_zoom


func _physics_process(delta):
	if get_parent().sprinting:
		zoom = zoom.move_toward(player_move_zoom, camera_speed * delta)
	else:
		zoom = zoom.move_toward(standard_zoom, camera_speed * delta)

