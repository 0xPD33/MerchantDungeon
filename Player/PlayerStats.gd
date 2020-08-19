extends Node

export(int) var max_health = 10
onready var health = max_health setget set_health

export(int) var max_stamina = 10
onready var stamina = max_stamina setget set_stamina

signal no_health
signal no_stamina


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")


func set_stamina(value):
	stamina = value
	if stamina <= 0:
		emit_signal("no_stamina")


func check_stamina():
	var enough : bool
	
	if stamina > 0:
		enough = true
	else:
		enough = false
	
	return enough


func regenerate():
	while stamina < max_stamina:
		stamina += 0.1
		if stamina >= max_stamina / 4:
			get_parent().can_sprint = true
		break

