extends Node2D

var entity_inside = null
var is_inside = false

var move_speed_multiplier = 0.5


func _process(delta):
	if entity_inside != null:
		while is_inside:
			slowdown()
			break


func slowdown():
	entity_inside.max_speed = entity_inside.max_speed * move_speed_multiplier


func _on_SlowArea_body_entered(body: Node):
	if !body.is_in_group("Spider"):
		entity_inside = body
		is_inside = true


func _on_SlowArea_body_exited(body: Node):
	if !body.is_in_group("Spider"):
		is_inside = false
		entity_inside = null


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") or area.is_in_group("Projectile"):
		if area.is_in_group("Projectile"):
			area.impact(global_position)
			area.queue_free()
		$SlowArea.call_deferred("set_monitorable", false)
		$AnimationPlayer.play("disappear")
		yield($AnimationPlayer, "animation_finished")
		queue_free()


