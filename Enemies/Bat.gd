extends "res://Enemies/Enemy.gd"

onready var anim_player = $AnimationPlayer
onready var hit_anim = $HitAnimation


func _physics_process(delta: float):
	match state:
		CHASE:
			anim_player.play("bat_move")


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox"):
		stats.health -= area.damage
		create_popup_damage(area.damage, Color.white, Vector2(0.3, 0.3))
		hurtbox.start_invincibility(0.5)
		hit_anim.play("bat_hit")
		# knockback = area.knockback_vector * 100

