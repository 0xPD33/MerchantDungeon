extends Node

export (int) var gold = 0 setget set_gold
export (int) var keys = 0 setget set_keys
export (int) var health_potions = 0 setget set_health_potions

onready var pickup_sound = get_parent().get_node("PickupSound")
onready var stats = get_parent().get_node("Stats")


func set_gold(value):
	gold = value
	get_tree().call_group("HUD", "set_gold", gold)


func set_keys(value):
	keys = value
	get_tree().call_group("HUD", "set_keys", keys)


func set_health_potions(value):
	health_potions = value
	get_tree().call_group("HUD", "set_health_potions", health_potions)


func pickup_item(item):
	pickup_audio(item.pickup_audio)
	
	if item.is_in_group("Gold"):
		self.gold += item.gold_amount
		if gold >= 3:
			get_tree().call_group("HUD", "change_gold_texture", item.big_texture)
	elif item.is_in_group("Key"):
		self.keys += 1
	elif item.is_in_group("Heart"):
		if stats.health < stats.max_health:
			stats.health += item.heal_amount
	elif item.is_in_group("HealthPotion"):
		self.health_potions += 1
	elif item.is_in_group("HealthUpgrade"):
		stats.max_health += item.increase_amount
		stats.health = stats.max_health
		get_tree().call_group("HUD", "setup_bars")
	elif item.is_in_group("StaminaUpgrade"):
		stats.max_stamina += item.increase_amount
		stats.stamina = stats.max_stamina
		get_tree().call_group("HUD", "setup_bars")
	elif item.is_in_group("SpeedUpgrade"):
		get_parent().set_normal_speed(get_parent().normal_speed + item.increase_amount)
		get_parent().set_sprint_speed(get_parent().normal_speed + item.increase_amount)
		get_parent().set_max_speed(get_parent().normal_speed)
	elif item.is_in_group("AreaOfSightUpgrade"):
		stats.set_area_of_sight(stats.area_of_sight + item.increase_amount)


func pickup_audio(stream):
	pickup_sound.stream = stream
	pickup_sound.play()

