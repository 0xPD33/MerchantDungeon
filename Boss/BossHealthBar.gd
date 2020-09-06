extends Control

var setup_done = false
var is_visible = false


func _ready():
	hide()


func setup(boss_name : String, max_health : int):
	setup_done = false
	var boss_name_label = get_node("VBoxContainer/BossName")
	var healthbar = get_node("VBoxContainer/TextureProgress")
	boss_name_label.text = boss_name
	healthbar.max_value = max_health
	healthbar.value = healthbar.max_value
	setup_done = true


func show_self():
	if setup_done:
		show()
		$AnimationPlayer.play("show")
		yield($AnimationPlayer, "animation_finished")
		is_visible = true


func update_health(value):
	get_node("VBoxContainer/TextureProgress").value = value

