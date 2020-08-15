extends Area2D

var damage = null

func _ready():
	if get_parent().is_in_group("Enemy"):
		damage = get_parent().get_node("Stats").damage

