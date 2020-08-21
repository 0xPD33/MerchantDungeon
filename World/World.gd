extends Node2D

var start_delay : float = 1.0


func _ready():
	yield(get_tree(), "idle_frame")
	if !Global.tutorial_shown:
		show_help()
	Global.game_started = true


func show_help():
	yield(get_tree().create_timer(start_delay), "timeout")
	get_tree().call_group("HUD", "show_help")

