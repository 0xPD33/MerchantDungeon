extends StaticBody2D

export (bool) var locked = false

var player_in_range

var opened = false

onready var door_collision = $DoorCollision
onready var detection_area = $DetectionArea

onready var anim_player = $AnimationPlayer


func _input(_event):
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			if !opened:
				open()
			else:
				close()


func open():
	anim_player.play("open_anim")
	yield(anim_player, "animation_finished")
	opened = true
	door_collision.call_deferred("set_disabled", true)


func close():
	anim_player.play("close_anim")
	yield(anim_player, "animation_finished")
	opened = false
	door_collision.call_deferred("set_disabled", false)


func _on_DetectionArea_body_entered(body: Node):
	if !locked:
		if body.is_in_group("Player"):
			player_in_range = true


func _on_DetectionArea_body_exited(body: Node):
	if !locked:
		if body.is_in_group("Player"):
			player_in_range = false
			if opened:
				close()

