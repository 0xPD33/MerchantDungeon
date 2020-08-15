extends Node2D

export var attack_range = 30
export var attack_duration = 0.2
export var attack_damage = 1
# export var attack_knockback = 50

var attack_cooldown = attack_duration * 2

var attacking = false

onready var body = $Body
onready var origin_pos = body.position.x

onready var hitbox = $Body/Hitbox
onready var attack_tween = $AttackTween

signal attack_done


func _ready():
	add_to_group("Weapon")
	hitbox.damage = attack_damage
	hitbox.monitorable = false


func attack():
	if !attacking:
		attacking = true
		attack_tween.interpolate_property(body, "position:x", body.position.x, attack_range, attack_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		attack_tween.interpolate_property(body, "position:x", attack_range, origin_pos, attack_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT, attack_duration)
		attack_tween.interpolate_callback(self, attack_cooldown, "_attack_complete")
		attack_tween.start()
		hitbox.monitorable = true
	else:
		return


func _attack_complete():
	hitbox.monitorable = false
	attacking = false
	emit_signal("attack_done")

