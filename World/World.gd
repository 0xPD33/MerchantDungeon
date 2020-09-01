extends Node2D

var help_delay : float = 2.0

onready var intro_sequence = $IntroSequencePlayer


func _ready():
	add_to_group("World")
	yield(get_tree(), "idle_frame")
	intro_sequence.play("beginning")
	yield(intro_sequence, "animation_finished")
	if !Global.tutorial_shown:
		show_help()
	Global.game_started = true


func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func show_help():
	yield(get_tree().create_timer(help_delay), "timeout")
	get_tree().call_group("HUD", "show_help")


func launch_credits():
	get_tree().change_scene("res://UI/Credits.tscn")


