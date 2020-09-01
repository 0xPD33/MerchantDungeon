extends Node2D

export (float) var attack_duration = 0.2
export (float) var attack_damage = 1

export (int) var attack_range = 30
export (int) var attack_knockback = 100

export (int) var weapon_distance = 12

var attack_cooldown = attack_duration * 2
var attack_direction

var attacking = false
var can_attack = true

onready var weapon_body = $Body
onready var origin_pos = weapon_body.position

onready var hitbox = $Body/Hitbox
onready var attack_tween = $AttackTween

onready var swing_audio = $SwingAudio
onready var raycast = $RayCast2D

signal attack_done


func _ready():
	connect("attack_done", get_parent().get_parent(), "_on_weapon_attack_done")
	hitbox.damage = attack_damage
	hitbox.knockback_amount = attack_knockback
	hitbox.monitorable = false
	raycast.position.x = weapon_body.position.x


func _process(_delta):
	attack_direction = (get_global_mouse_position() - $Body.global_position).normalized()
	hitbox.knockback_vector = attack_direction
	handle_collisions()


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
		play_swing_audio()
		hitbox.monitorable = true
	else:
		return


func play_swing_audio():
	randomize()
	swing_audio.pitch_scale = rand_range(0.5, 1.5)
	swing_audio.play()


func _attack_complete():
	hitbox.monitorable = false
	attacking = false
	emit_signal("attack_done")

