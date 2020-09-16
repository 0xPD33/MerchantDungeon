extends Node

signal health_changed(value)
signal stamina_changed(value)
signal no_health
signal no_stamina

var area_of_sight = 0.25 setget set_area_of_sight

var max_health = 6 setget set_max_health
var max_stamina = 12 setget set_max_stamina

var regenerating = false setget set_regenerating
var started_regen = false

onready var health = max_health setget set_health
onready var stamina = max_stamina setget set_stamina


func set_area_of_sight(value):
	area_of_sight = value
	get_parent().player_light.texture_scale = value


func set_max_health(value):
	max_health = value


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")


func set_max_stamina(value):
	max_stamina = value


func set_stamina(value):
	stamina = value
	emit_signal("stamina_changed", stamina)
	if stamina <= 0:
		emit_signal("no_stamina")


func set_regenerating(value):
	regenerating = value
	if regenerating:
		regenerate()


func _ready():
	connect("health_changed", self, "_on_health_changed")
	connect("stamina_changed", self, "_on_stamina_changed")


func regenerate():
	if stamina < max_stamina:
		set_stamina(stamina + 0.1)
		if stamina >= max_stamina / 5:
			get_parent().can_sprint = true


func _on_health_changed(value):
	get_tree().call_group("HUD", "update_healthbar", value)


func _on_stamina_changed(value):
	get_tree().call_group("HUD", "update_staminabar", value)

