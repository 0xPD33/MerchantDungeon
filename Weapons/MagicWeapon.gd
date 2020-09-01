extends Node2D

export (PackedScene) var projectile
export (float) var projectile_damage = 1

export (float) var attack_duration = 0.2
export (int) var attack_range = 30

export (int) var weapon_distance = 12

var attack_cooldown = attack_duration * 2
var attack_direction

var attacking = false
var can_attack = true

onready var weapon_body = $Body
onready var projectile_position = $Body/ProjectilePosition
onready var origin_pos = weapon_body.position

onready var attack_tween = $AttackTween

onready var raycast = $RayCast2D

signal attack_done


func _ready():
	connect("attack_done", get_parent().get_parent(), "_on_weapon_attack_done")
	raycast.position.x = weapon_body.position.x


func _process(_delta):
	attack_direction = (get_global_mouse_position() - $Body.global_position).normalized()
	handle_collisions()
	check_player_stamina()


func check_player_stamina():
	if get_parent().get_parent().stats.stamina > 1:
		can_attack = true
	else:
		can_attack = false


func handle_collisions():
	if raycast.is_colliding():
		var object_collided_with = raycast.get_collider()
		if object_collided_with.is_in_group("Walls"):
			can_attack = false
	else:
		can_attack = true


func attack():
	if !attacking and can_attack:
		attacking = true
		attack_tween.interpolate_property(weapon_body, "position:x", weapon_body.position.x, attack_range, attack_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		attack_tween.interpolate_property(weapon_body, "position:x", attack_range, origin_pos.x, attack_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT, attack_duration)
		attack_tween.interpolate_callback(self, attack_cooldown, "_attack_complete")
		attack_tween.start()
	else:
		return


func shoot_projectile():
	var projectile_instance = projectile.instance()
	get_tree().current_scene.get_node("YSort/Projectiles").add_child(projectile_instance)
	projectile_instance.shoot(projectile_damage, attack_direction, projectile_position.global_position)
	get_parent().get_parent().stats.stamina -= get_parent().get_parent().stats.stamina


func _attack_complete():
	attacking = false
	shoot_projectile()
	emit_signal("attack_done")

