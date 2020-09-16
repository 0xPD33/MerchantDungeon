extends Popup

signal advance_tutorial

var opened = false
var advancing = false

var tutorial_stage : int = 0
var tutorial_delay : float = 1.5
var tutorial_text = ["WASD to move.", "Left mouse button to attack.", "Try destroying the barrel.",
					 "Gold and health is picked up automatically.", "Press E to interact.", "Hold Shift to sprint."]

var barrel_destroyed = false
var item_picked_up = false
var weapon_picked_up = false

onready var tutorial_label = $TutorialLabel
onready var anim_player = $AnimationPlayer


func _process(delta: float):
	if opened:
		match tutorial_stage:
			0:
				_get_input("move")
			1:
				_get_input("attack")
			2:
				_wait_for_event("barrel_destroyed")
			3:
				_wait_for_event("item_picked_up")
			4:
				_get_input("interact")
			5:
				_get_input("sprint")
			6:
				pass


func _get_input(type : String):
	match type:
		"move":
			if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
				emit_signal("advance_tutorial")
		"attack":
			if Input.is_action_just_pressed("attack"):
				emit_signal("advance_tutorial")
		"interact":
			if Input.is_action_just_pressed("interact"):
				emit_signal("advance_tutorial")
		"sprint":
			if Input.is_action_just_pressed("sprint"):
				close_tutorial()


func _wait_for_event(event: String):
	match event:
		"barrel_destroyed":
			if barrel_destroyed:
				close_tutorial()
				yield(get_tree().create_timer(tutorial_delay), "timeout")
				show_tutorial()
			else:
				pass
		"item_picked_up":
			if item_picked_up:
				close_tutorial()
				yield(get_tree().create_timer(tutorial_delay), "timeout")
				show_tutorial()
			else:
				pass


func advance_tutorial():
	if !advancing:
		advancing = true
		if tutorial_stage < tutorial_text.size():
			tutorial_stage += 1
			tutorial_label.text = tutorial_text[tutorial_stage]
		advancing = false


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


func _on_Barrel_destroyed():
	barrel_destroyed = true


func _on_Tutorial_advance_tutorial():
	close_tutorial()
	yield(get_tree().create_timer(tutorial_delay), "timeout")
	show_tutorial()

