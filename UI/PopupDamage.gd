extends Node2D


func _ready():
	hide()


func popup_damage(damage):
	$Label.text = "-" + str(damage)
	show()
	$AnimationPlayer.play("popup_damage_anim")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

