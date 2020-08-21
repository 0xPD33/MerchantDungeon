extends Control

var player = null
var setup_done = false

var help_shown = false

onready var healthbar = $BarContainer/Healthbar/TextureProgress
onready var health_label = $BarContainer/Healthbar/TextureProgress/Label

onready var staminabar = $BarContainer/Staminabar/TextureProgress
onready var stamina_label = $BarContainer/Staminabar/TextureProgress/Label

onready var gold_texture = $GoldContainer/GoldTexture
onready var gold_label = $GoldContainer/GoldLabel

onready var potion_count = $HealthPotionContainer/PotionCount

onready var help_panel = $HelpPanel


func _ready():
	get_player()
	setup_bars()
	set_gold(0)
	set_health_potions(0)
	add_to_group("HUD")
	setup_done = true


func _process(_delta: float):
	if setup_done:
		update_healthbar()
		update_staminabar()


func _input(event):
	if Input.is_action_just_pressed("show_help"):
		if !help_panel.is_visible:
			show_help()
		else:
			hide_help()


func get_player():
	player = get_tree().current_scene.get_node("YSort/Player")


func show_help():
	help_panel.show_help()


func hide_help():
	help_panel.hide_help()


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


func set_health_potions(amount):
	if player != null:
		potion_count.text = str(amount)


func update_healthbar():
	if player != null:
		healthbar.value = player.stats.health
		health_label.text = str(player.stats.health)


func update_staminabar():
	if player != null:
		staminabar.value = player.stats.stamina
		if player.stats.stamina >= 0:
			stamina_label.text = str(round(player.stats.stamina))

