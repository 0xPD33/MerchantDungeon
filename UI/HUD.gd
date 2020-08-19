extends Control

var setup_done = false

var player = null

onready var healthbar = $BarContainer/Healthbar/TextureProgress
onready var health_label = $BarContainer/Healthbar/TextureProgress/Label

onready var staminabar = $BarContainer/Staminabar/TextureProgress
onready var stamina_label = $BarContainer/Staminabar/TextureProgress/Label

onready var gold_texture = $GoldContainer/GoldTexture
onready var gold_label = $GoldContainer/GoldLabel


func _ready():
	get_player()
	setup_bars()
	set_gold(0)
	add_to_group("HUD")
	setup_done = true


func _process(_delta: float):
	if setup_done:
		update_healthbar()
		update_staminabar()


func get_player():
	player = get_tree().current_scene.get_node("YSort/Player")


func setup_bars():
	healthbar.max_value = player.stats.max_health
	health_label.text = str(player.stats.max_health)
	staminabar.max_value = player.stats.max_stamina
	stamina_label.text = str(player.stats.max_stamina)


func set_gold(amount):
	if player != null:
		gold_label.text = str(amount)


func change_gold_texture(new_texture):
	gold_texture.texture = new_texture


func update_healthbar():
	if player != null:
		healthbar.value = player.stats.health
		health_label.text = str(player.stats.health)


func update_staminabar():
	if player != null:
		staminabar.value = player.stats.stamina
		if player.stats.stamina >= 0:
			stamina_label.text = str(round(player.stats.stamina))

