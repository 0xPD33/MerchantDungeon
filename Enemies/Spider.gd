extends "res://Enemies/Enemy.gd"

onready var anim_player = $AnimationPlayer


func _physics_process(delta: float):
	if player_detection_zone.player != null:
		look_at(player_detection_zone.player.global_position)
	
	match state:
		CHASE:
			anim_player.play("spider_move")

