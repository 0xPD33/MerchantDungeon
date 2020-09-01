extends Panel

var merchant

var dialogue setget set_dialogue
var answers setget set_answers


func _ready():
	hide()
	set_process_input(false)


func _input(_event):
	if Input.is_action_just_pressed("interact"):
		set_process_input(false)
		merchant.talk("A")
	elif Input.is_action_just_pressed("interact_secondary"):
		set_process_input(false)
		merchant.talk("B")


func set_dialogue(value):
	dialogue = value
	$VBoxContainer/Dialogue.text = value


func set_answers(value):
	answers = value
	$VBoxContainer/Answers.text = value


func start_dialogue():
	$AnimationPlayer.playback_speed = 60.0 / dialogue.length()
	$AnimationPlayer.play("animate_dialogue")


func open():
	show()
	start_dialogue()


func _on_AnimationPlayer_animation_finished(anim_name: String):
	set_process_input(true)

