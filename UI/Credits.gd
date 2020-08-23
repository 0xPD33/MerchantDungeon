extends Control

onready var anim_player = $AnimationPlayer


func _ready():
	anim_player.play("thanks_animation")
	yield(anim_player, "animation_finished")
	anim_player.play("credits_animation")
	yield(anim_player, "animation_finished")
	get_tree().quit()

