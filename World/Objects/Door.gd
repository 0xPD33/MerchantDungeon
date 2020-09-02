extends StaticBody2D

var player_in_range

var opened = false

onready var door_collision = $DoorCollision
onready var detection_area = $DetectionArea

onready var anim_player = $AnimationPlayer
onready var door_sound = $DoorSound


func _input(_event):
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			if !opened:
				open()
			else:
				close()


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
		player_in_range = true


func _on_DetectionArea_body_exited(body: Node):
	if body.is_in_group("Player"):
		player_in_range = false
		if opened:
			close()

