extends Panel

var player

var tutorial_state = 0
var tutorial_state_max

var tutorial_state_text = ["WASD to move.", "Left mouse button to attack.",
						   "You can destroy barrels and cobwebs. Try it out!",
						   "E to interact.", "Shift to sprint."]

onready var tutorial_text = $TutorialText
onready var wait_timer = $WaitTimer
onready var anim_player = $AnimationPlayer


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")
	tutorial_state_max = tutorial_state_text.size() - 1
	hide()
	setup_tutorial_text()


func setup_tutorial_text():
	tutorial_text.text = tutorial_state_text[tutorial_state]


func show_tutorial():
	show()
	anim_player.play("tutorial_fade_in")
	yield(anim_player, "animation_finished")
	wait_timer.start()


func hide_tutorial():
	anim_player.play("tutorial_fade_out")
	yield(anim_player, "animation_finished")
	hide()
	if tutorial_state < tutorial_state_max:
		tutorial_state += 1
	setup_tutorial_text()


func _on_WaitTimer_timeout():
	hide_tutorial()
	if tutorial_state < tutorial_state_max:
		yield(get_tree().create_timer(2.0), "timeout")
		show_tutorial()
	else:
		Global.tutorial_done = true
		queue_free()

