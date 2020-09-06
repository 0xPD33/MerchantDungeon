extends Node2D

onready var explosion_audio = $AudioStreamPlayer2D


func _ready():
	explosion_audio = Global.randomize_sound_pitch(explosion_audio, 2.0, 2.5)
	$AnimationPlayer.play("explode")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

