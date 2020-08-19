extends "res://Enemies/Enemy.gd"

var moving_faster = false


func _ready():
	$MoveSpeedTimer.start()


func _physics_process(delta: float):
	if !dead:
		match state:
			CHASE:
				move_anim.play("goblin_move")
	else:
		hurtbox.set_deferred("monitorable", false)
		hitbox.set_deferred("monitorable", false)


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") and !hit:
		hit = true
		stats.health -= area.damage
		create_popup_damage(area.damage, Color.white, Vector2(0.3, 0.3))
		hurtbox.start_invincibility(0.5)
		hit_anim.play("goblin_hit")
		knockback = area.knockback_vector * (area.knockback_amount * stats.knockback_multiplier)


func _on_Stats_no_health():
	dead = true
	death_anim.play("goblin_death")
	yield(death_anim, "animation_finished")
	queue_free()


func _on_MoveSpeedTimer_timeout():
	if !dead:
		max_speed = max_speed * 2
		moving_faster = true
		yield(get_tree().create_timer(1.0), "timeout")
		max_speed = normal_speed
	else:
		pass

