extends Area2D

var projectile_speed = 175 setget set_projectile_speed
var projectile_direction

onready var raycast = $RayCast2D


func set_projectile_speed(value):
	projectile_speed = value


func _physics_process(delta: float):
	global_position += projectile_direction * (projectile_speed * delta)
	handle_collisions()


func handle_collisions():
	if raycast.is_colliding():
		var object_collided_with = raycast.get_collider()
		if object_collided_with.is_in_group("Walls"):
			queue_free()
	else:
		pass


func shoot(direction, shoot_pos):
	projectile_direction = direction
	global_position = shoot_pos
	global_rotation = direction.angle()

