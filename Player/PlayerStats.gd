extends Node

var area_of_sight = 0.25 setget set_area_of_sight

var max_health = 6 setget set_max_health
var max_stamina = 12 setget set_max_stamina

onready var health = max_health setget set_health
onready var stamina = max_stamina setget set_stamina

signal no_health
signal no_stamina


func set_area_of_sight(value):
	area_of_sight = value
	get_parent().player_light.texture_scale = value


func set_max_health(value):
	max_health = value


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")


func set_max_stamina(value):
	max_stamina = value


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

