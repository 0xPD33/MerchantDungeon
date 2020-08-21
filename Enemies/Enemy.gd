extends KinematicBody2D

const POPUP_DAMAGE = preload("res://UI/PopupDamage.tscn")
const HIT_EFFECT = preload("res://Effects/HitEffect.tscn")

export var acceleration = 100
export var max_speed = 50
export var friction = 100

enum {
	IDLE,
	WANDER,
	CHASE,
	CHARGE
}

var hit = false
var dead = false

var player = null

var state = IDLE

var velocity = Vector2.ZERO

var knockback = Vector2.ZERO

onready var move_anim = $MoveAnimation
onready var hit_anim = $HitAnimation
onready var death_anim = $DeathAnimation

onready var idle_timer = $IdleTimer
onready var idle_audio = $IdleAudio

onready var player_detection_zone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox

onready var stats = $Stats
onready var drops = $Drops

onready var normal_speed = max_speed


func _ready():
	hitbox.damage = stats.damage
	add_to_group("Enemy")
	idle_timer.start()


func _physics_process(delta: float):
	if !dead:
		knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
		knockback = move_and_slide(knockback)
		
		match state:
			IDLE:
				velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
				seek_player()
			WANDER:
				pass
			CHASE:
				player = player_detection_zone.player
				if player != null:
					var direction = (player.global_position - global_position).normalized()
					velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
				else:
					state = IDLE
		
		velocity = move_and_slide(velocity)
	else:
		pass


func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE


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


