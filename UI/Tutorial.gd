extends Popup

var opened = false
var tutorial_stage : int = 0
var tutorial_text = ["WASD to move.", "Left mouse button to attack.",
					 "E to interact.", "Shift to sprint."]

onready var tutorial_label = $TutorialLabel
onready var anim_player = $AnimationPlayer


func advance_tutorial():
	tutorial_stage += 1
	tutorial_label.text = tutorial_text[tutorial_stage]


func show_tutorial():
	popup()
	anim_player.play("show")
	yield(anim_player, "animation_finished")
	opened = true


func close_tutorial():
	anim_player.play("hide")
	yield(anim_player, "animation_finished")
	hide()
	opened = false
	advance_tutorial()


func _on_tutorial_triggered():
	close_tutorial()
	yield(get_tree().create_timer(2.5), "timeout")
	show_tutorial()

