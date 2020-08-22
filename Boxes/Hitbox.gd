extends Area2D

var knockback_vector = Vector2.ZERO
var knockback_amount

var damage = null


func _ready():
	add_to_group("Hitbox")
	if get_parent().is_in_group("Enemy"):
		damage = get_parent().get_node("Stats").damage
	if get_parent().is_in_group("Boss"):
		damage = get_parent().get_node("BossStats").damage

