extends "res://Enemies/Enemy.gd"


func _physics_process(delta: float):
	if !dead:
		if player_detection_zone.player != null:
			look_at(player_detection_zone.player.global_position)
		
		match state:
			CHASE:
				move_anim.play("spider_move")
	else:
		hurtbox.set_deferred("monitorable", false)
		hitbox.set_deferred("monitorable", false)


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") and !hit:
		hit = true
		stats.health -= area.damage
		create_popup_damage(area.damage, Color.white, Vector2(0.3, 0.3))
		hurtbox.start_invincibility(0.5)
		hit_anim.play("spider_hit")
		knockback = area.knockback_vector * (area.knockback_amount * stats.knockback_multiplier)


func _on_Stats_no_health():
	dead = true
	death_anim.play("spider_death")
	yield(death_anim, "animation_finished")
	queue_free()

