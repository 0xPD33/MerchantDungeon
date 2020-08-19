extends Panel

var current_weapon

var actual_weapon_name : String
var damage : float

onready var weapon_name = $CenterContainer/VBoxContainer/WeaponName
onready var damage_label = $CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/DamageLabel


func _ready():
	current_weapon = get_tree().current_scene.get_node("YSort/Player/WeaponPosition").get_child(0)
	get_properties()
	setup_text()


func get_properties():
	if "WoodenStick" in get_parent().name:
		actual_weapon_name = "Wooden Stick"
		damage = 1
	if "BrokenSword" in get_parent().name:
		actual_weapon_name = "Broken Sword"
		damage = 2


func setup_text():
	weapon_name.text = actual_weapon_name
	if damage > current_weapon.attack_damage:
		damage_label.text = "Dmg: " + str(damage) + " (current:  " + str(current_weapon.attack_damage) + ")"
	else:
		damage_label.text = "Dmg: " + str(damage)
