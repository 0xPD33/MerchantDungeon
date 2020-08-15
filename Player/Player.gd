extends KinematicBody2D

var acceleration = 200
var friction = 200

var max_speed
var normal_speed = 75
var sprint_speed = 125

var velocity = Vector2.ZERO

var moving = false
var sprinting = false

var can_attack = true

onready var anim_player = $AnimationPlayer

onready var weapon_position = $WeaponPosition
onready var weapon = weapon_position.get_node("Weapon")
onready var weapon_distance = weapon_position.position.length()

onready var hurtbox = $Hurtbox

onready var stats = $Stats


func _ready():
	stats.connect("no_health", self, "queue_free")
	max_speed = normal_speed
	add_to_group("Player")


func _physics_process(delta: float):
	_input_vector(delta)
	_move_weapon()
	_move_player()


func _input_vector(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		anim_player.play("move")
		moving = true
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		anim_player.play("move_stop")
		moving = false
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)


func _input(_event):
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false
		weapon.attack()


func _move_player():
	move_and_slide(velocity)
	
	var can_sprint = stats.check_stamina()
	
	if Input.is_action_pressed("sprint") and can_sprint:
		sprinting = true
		anim_player.playback_speed = 2
		max_speed = sprint_speed
		if moving:
			stats.stamina -= 0.1
	else:
		sprinting = false
		anim_player.playback_speed = 1
		max_speed = normal_speed
		stats.regenerate()


func _move_weapon():
	weapon_position.look_at(get_global_mouse_position())


func _on_Weapon_attack_done():
	can_attack = true


func _on_Hurtbox_area_entered(area: Area2D):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.5)

