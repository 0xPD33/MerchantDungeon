extends Area2D

export (PackedScene) var impact_effect

export (float) var projectile_speed = 200
export (int) var knockback_amount = 100

var damage

var direction
var knockback_vector

var impact_done = false

onready var particles = $CPUParticles2D
onready var raycast = $RayCast2D


func _physics_process(delta: float):
	global_position += direction * (projectile_speed * delta)
	handle_collisions()


func handle_collisions():
	if raycast.is_colliding():
		var object_collided_with = raycast.get_collider()
		if object_collided_with.is_in_group("Walls"):
			impact(global_position)
			queue_free()
	else:
		pass


func shoot(dmg, weapon_direction, shoot_pos):
	damage = dmg
	direction = weapon_direction
	knockback_vector = direction
	global_position = shoot_pos
	global_rotation = direction.angle()
	particles.emitting = true


func impact(pos):
	var instance = impact_effect.instance()
	instance.global_position = pos
	get_tree().current_scene.add_child(instance)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

