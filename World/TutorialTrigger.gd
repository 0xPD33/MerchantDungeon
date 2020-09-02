extends Area2D

signal tutorial_triggered

var triggered = false


func _ready():
	connect("tutorial_triggered", get_tree().current_scene.get_node("UI/HUD/Tutorial"), "_on_tutorial_triggered")


func _on_TutorialTrigger_body_entered(body: Node):
	if body.is_in_group("Player") and !triggered:
		triggered = true
		emit_signal("tutorial_triggered")

