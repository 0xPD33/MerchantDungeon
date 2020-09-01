extends Panel

var current_weapon

onready var weapon_name = $CenterContainer/VBoxContainer/WeaponName
onready var weapon_description = $CenterContainer/VBoxContainer/WeaponDescription
onready var damage_label = $CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/DamageLabel


func setup():
	current_weapon = get_tree().current_scene.get_node("YSort/Player/WeaponPosition").get_child(0)
	weapon_name.text = get_parent().actual_weapon_name
	weapon_description.text = get_parent().weapon_description
	
	var current_damage
	if current_weapon.is_in_group("MeleeWeapon"):
		current_damage = current_weapon.attack_damage
	elif current_weapon.is_in_group("MagicWeapon"):
		current_damage = current_weapon.projectile_damage
		
	if get_parent().damage > current_damage:
		damage_label.text = "Dmg: " + str(get_parent().damage) + " (current:  " + str(current_damage) + ")"
	else:
		damage_label.text = "Dmg: " + str(get_parent().damage)

