extends Node

export(int) var max_health = 10
onready var health = max_health setget set_health

export(float) var damage = 1
export(float) var knockback_multiplier = 1

signal no_health


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")

