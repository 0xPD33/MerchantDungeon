extends Control

var player = null
var setup_done = false

var help_shown = false

onready var healthbar = $BarContainer/Healthbar/TextureProgress
onready var health_label = $BarContainer/Healthbar/TextureProgress/Label

onready var staminabar = $BarContainer/Staminabar/TextureProgress
onready var stamina_label = $BarContainer/Staminabar/TextureProgress/Label

onready var gold_texture = $VBoxContainer/GoldContainer/GoldTexture
onready var gold_label = $VBoxContainer/GoldContainer/GoldLabel

onready var key_count = $VBoxContainer/KeyContainer/KeyCount

onready var potion_count = $VBoxContainer/HealthPotionContainer/PotionCount

onready var death_label = $DeathLabel

onready var help_panel = $HelpPanel
onready var pause_menu = $PauseMenu


func _ready():
	get_player()
	setup_bars()
	set_gold(0)
	set_health_potions(0)
	add_to_group("HUD")
	setup_done = true


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
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


func show_death_label():
	death_label.get_node("AnimationPlayer").play("death_label_anim")


func pause_game():
	pause_menu.open()


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


func set_keys(amount):
	if player != null:
		key_count.text = str(amount)


func set_health_potions(amount):
	if player != null:
		potion_count.text = str(amount)


func update_healthbar(value):
	if player != null:
		if value > 0:
			healthbar.value = value
			health_label.text = str(value)
		else:
			healthbar.value = 0
			health_label.text = str(0)


func update_staminabar(value):
	if player != null:
		if value > 0:
			staminabar.value = value
			stamina_label.text = str(round(value))
		else:
			staminabar.value = 0
			stamina_label.text = str(0)

