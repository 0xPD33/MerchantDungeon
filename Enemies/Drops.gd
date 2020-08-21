extends "res://Items/ItemSpawner.gd"

var gold = preload("res://Items/Gold.tscn")
var heart = preload("res://Items/Heart.tscn")

var possible_drops = [gold]

var drop_chance = 50


func allow_heart_drop():
	if get_parent().player.stats.health < get_parent().player.stats.max_health:
		possible_drops.append(heart)
	else:
		possible_drops.erase(heart)


func drop_weapon():
	if get_parent().weapon_drop != null:
		spawn_item(get_parent().weapon_drop, get_parent().global_position)


func drop_item():
	randomize()
	allow_heart_drop()
	var drop_selector = randi() % 100 + 1
	if get_parent().is_in_group("Barrel"):
		drop_chance = 100
	
	if drop_selector >= 0:
		if possible_drops != null and drop_selector <= drop_chance:
			var item_drop = possible_drops[randi() % possible_drops.size()]
			spawn_item(item_drop, get_parent().global_position)

