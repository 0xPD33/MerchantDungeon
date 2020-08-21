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
	if "IronDagger" in get_parent().name:
		actual_weapon_name = "Iron Dagger"
		damage = 2
	if "IronSword" in get_parent().name:
		actual_weapon_name = "Iron Sword"
		damage = 3
	if "WoodenStaff" in get_parent().name:
		actual_weapon_name = "Wooden Staff"
		damage = 1


func setup_text():
	weapon_name.text = actual_weapon_name
	var current_damage
	if current_weapon.is_in_group("MeleeWeapon"):
		current_damage = current_weapon.attack_damage
	elif current_weapon.is_in_group("MagicWeapon"):
		current_damage = current_weapon.projectile_damage
	if damage > current_damage:
		damage_label.text = "Dmg: " + str(damage) + " (current:  " + str(current_damage) + ")"
	else:
		damage_label.text = "Dmg: " + str(damage)

