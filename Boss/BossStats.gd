extends Node

export(int) var max_health = 100
onready var health = max_health setget set_health

export(float) var damage = 1 setget set_damage
export(float) var knockback_multiplier = 0.8

signal no_health
signal health_changed(value)


func set_damage(value):
	damage = value


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

