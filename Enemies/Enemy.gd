extends KinematicBody2D

export var acceleration = 100
export var max_speed = 50
export var friction = 100

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

var velocity = Vector2.ZERO

# var knockback = Vector2.ZERO

onready var stats = $Stats
onready var player_detection_zone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox


func _ready():
	hitbox.damage = stats.damage
	add_to_group("Enemy")


func _physics_process(delta: float):
#	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
#	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = player_detection_zone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
			else:
				state = IDLE
	
	velocity = move_and_slide(velocity)


func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE


func _on_Hurtbox_area_entered(area: Area2D):
	stats.health -= area.damage
	# knockback = area.knockback_vector * 100


func _on_EnemyStats_no_health():
	queue_free()

