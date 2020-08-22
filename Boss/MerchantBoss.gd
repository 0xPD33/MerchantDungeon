extends KinematicBody2D

const POPUP_DAMAGE = preload("res://UI/PopupDamage.tscn")
const HIT_EFFECT = preload("res://Effects/HitEffect.tscn")
const UNARMING_PROJECTILE = preload("res://Boss/UnarmingProjectile.tscn")

var acceleration = 125
var max_speed = 50 setget set_max_speed
var friction = 75

enum {
	STAGE0,
	STAGE1,
	STAGE2,
	STAGE3
}

var state = STAGE0

var changing_stage = false

var fight_started = false
var shooting_projectile = false

var projectile_wait_time = 5.0

var hit = false
var dead = false

var player = null

var direction
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox

onready var projectile_shoot_pos = $ProjectileShootPosition
onready var projectile_shoot_timer = $ProjectileShootTimer

onready var stage_anim = $StageAnimation
onready var attack_anim = $AttackAnimation
onready var move_anim = $MoveAnimation
onready var hit_anim = $HitAnimation
onready var death_anim = $DeathAnimation

onready var stats = $BossStats


func set_max_speed(value):
	max_speed = value


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")


func _physics_process(delta: float):
	if !dead and fight_started:
		knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
		knockback = move_and_slide(knockback)
		
		if player != null:
			if shooting_projectile or changing_stage:
				velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			else:
				direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		
		move_anim.play("boss_move")
		velocity = move_and_slide(velocity)
	else:
		pass


func start_fight():
	change_stage()


func change_stage():
	match state:
		STAGE0:
			stage_anim.play("boss_stage1")
			yield(stage_anim, "animation_finished")
			fight_started = true
			state = STAGE1
		STAGE1:
			changing_stage = true
			stage_anim.play("boss_stage2")
			yield(stage_anim, "animation_finished")
			projectile_shoot_timer.start(projectile_wait_time)
			set_max_speed(60)
			state = STAGE2
			changing_stage = false
		STAGE2:
			get_tree().call_group("BossMobSpawn", "start_timer")
			change_projectile_wait_time(3.0)
			set_max_speed(75)
			state = STAGE3
		STAGE3:
			change_projectile_wait_time(1.5)
			set_max_speed(90)


func change_projectile_wait_time(value : float):
	projectile_shoot_timer.stop()
	projectile_wait_time = value
	projectile_shoot_timer.start(projectile_wait_time)


func shoot_unarming_projectile():
	shooting_projectile = true
	attack_anim.play("boss_magic_attack")
	yield(attack_anim, "animation_finished")
	var projectile_instance = UNARMING_PROJECTILE.instance()
	get_tree().current_scene.get_node("YSort/Projectiles").add_child(projectile_instance)
	projectile_instance.shoot(direction, projectile_shoot_pos.global_position)
	yield(get_tree().create_timer(0.2), "timeout")
	shooting_projectile = false


func create_popup_damage(dmg, color, size):
	var instance = POPUP_DAMAGE.instance()
	get_tree().current_scene.add_child(instance)
	instance.modulate = color
	instance.scale = size
	instance.position = get_global_transform().origin
	instance.popup_damage(dmg)


func create_hit_effect(pos):
	randomize()
	pos.x += rand_range(-2, 2)
	pos.y += rand_range(-2, 2)
	var instance = HIT_EFFECT.instance()
	instance.position = pos
	get_tree().current_scene.add_child(instance)


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") or area.is_in_group("Projectile"):
		if !hit:
			hit = true
			stats.health -= area.damage
			hurtbox.start_invincibility(0.5)
			if area.is_in_group("Hitbox"):
				create_hit_effect(global_position)
			create_popup_damage(area.damage, Color.white, Vector2(0.5, 0.5))
			knockback = area.knockback_vector * (area.knockback_amount * stats.knockback_multiplier)
			if area.is_in_group("Projectile"):
				area.impact(global_position)
				area.queue_free()


func _on_BossStats_no_health():
	queue_free()


func _on_BossStats_health_changed(value):
	if value <= 80:
		change_stage()
	if value <= 50:
		change_stage()
	if value <= 20:
		change_stage()


func _on_ProjectileShootTimer_timeout():
	shoot_unarming_projectile()

