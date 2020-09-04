extends StaticBody2D

export (bool) var is_locked = false

var player
var player_in_range

var opened = false

onready var door_collision = $DoorCollision
onready var detection_area = $DetectionArea

onready var anim_player = $AnimationPlayer
onready var door_sound = $DoorSound


func _input(_event):
	if !is_locked:
		if player_in_range and player != null and Input.is_action_just_pressed("interact"):
			if !opened:
				open()
			else:
				close()
	else:
		if player_in_range and player != null and Input.is_action_just_pressed("interact"):
			if player.items.keys >= 1 and !opened:
				player.items.keys -= 1
				open()
			else:
				pass


func open():
	door_sound.pitch_scale = get_random_door_pitch()
	anim_player.play("open_anim")
	yield(anim_player, "animation_finished")
	door_collision.call_deferred("set_disabled", true)
	opened = true


func close():
	door_sound.pitch_scale = get_random_door_pitch()
	anim_player.play("close_anim")
	yield(anim_player, "animation_finished")
	door_collision.call_deferred("set_disabled", false)
	opened = false


func get_random_door_pitch():
	randomize()
	var random_pitch = rand_range(0.6, 0.9)
	return random_pitch


func _on_DetectionArea_body_entered(body: Node):
	if body.is_in_group("Player"):
		player = body
		player_in_range = true


func _on_DetectionArea_body_exited(body: Node):
	if body.is_in_group("Player"):
		player = null
		player_in_range = false
		if !is_locked:
			if opened:
				close()

