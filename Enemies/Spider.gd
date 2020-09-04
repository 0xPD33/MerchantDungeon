extends "res://Enemies/Enemy.gd"


func _ready():
	add_to_group("Spider")


func _physics_process(delta: float):
	if !dead:
		if player_detection_zone.player != null:
			look_at(player_detection_zone.player.global_position)
		
		match state:
			CHASE:
				move_anim.play("spider_move")
			IDLE:
				move_anim.play("spider_move_stop")
	else:
		hurtbox.set_deferred("monitorable", false)
		hitbox.set_deferred("monitorable", false)


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") or area.is_in_group("Projectile"):
		if !hit and !dead:
			hit = true
			stats.health -= area.damage
			hurtbox.start_invincibility(invincibility_time)
			if area.is_in_group("Hitbox"):
				create_hit_effect(global_position)
			create_popup_damage(area.damage, Color.white, Vector2(0.3, 0.3))
			hit_anim.play("spider_hit")
			knockback = area.knockback_vector * (area.knockback_amount * stats.knockback_multiplier)
			if area.is_in_group("Projectile"):
				area.impact(global_position)
				area.queue_free()


func _on_Stats_no_health():
	dead = true
	death_anim.play("spider_death")
	yield(death_anim, "animation_finished")
	drops.drop_item()
	queue_free()


func _on_IdleTimer_timeout():
	randomize()
	idle_audio.pitch_scale = rand_range(0.9, 1.1)
	idle_audio.play()

