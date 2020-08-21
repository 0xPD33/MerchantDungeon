extends Panel

var is_visible = false


func show_help():
	show()
	is_visible = true
	$AnimationPlayer.play("fade_in")
	Global.tutorial_shown = true


func hide_help():
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer, "animation_finished")
	hide()
	is_visible = false

