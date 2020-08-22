extends Node2D


func _ready():
	randomize()
	global_rotation_degrees += rand_range(-180, 180)
	$AnimationPlayer.play("hit")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

