extends KinematicBody2D

var player = null

var can_interact = false

var dialogue_state = 0
var introduced = false

onready var evil_anim = $EvilAnimation
onready var dialogue_panel = $DialoguePanel


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")
	add_to_group("NPC")


func _input(_event):
	if Input.is_action_just_pressed("interact") and can_interact:
		talk()


func show_dialogue():
	dialogue_panel.open()


func talk(answer = ""):
	dialogue_panel.merchant = self
	
	if !introduced:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogue_panel.dialogue = "Wait, where did you come from?"
				dialogue_panel.answers = "[E] - I don't know"
				show_dialogue()
			1:
				match answer:
					"A":
						dialogue_state = 2
						dialogue_panel.dialogue = "You are not the first to stumble into this place."
						dialogue_panel.answers = "[E] - What is this place?"
						show_dialogue()
			2:
				match answer:
					"A":
						dialogue_state = 3
						dialogue_panel.dialogue = "I can't explain that yet"
						dialogue_panel.answers = "[E] - Who are you?"
						show_dialogue()
			3:
				match answer:
					"A":
						dialogue_state = 4
						evil_anim.play("merchant_show_evil")
						dialogue_panel.dialogue = "Stop asking these questions!"
						dialogue_panel.answers = "[E] - Okay, okay!"
						show_dialogue()
			4:
				match answer:
					"A":
						introduced = true
						dialogue_state = 0
						dialogue_panel.hide()
						spawn_shop_items()


func spawn_shop_items():
	get_tree().call_group("ShopItemSpawn", "spawn_shop_item")


func _on_InteractRange_body_entered(body: Node):
	if body.is_in_group("Player"):
		can_interact = true


func _on_InteractRange_body_exited(body: Node):
	if body.is_in_group("Player"):
		dialogue_state = 0
		dialogue_panel.hide()
		can_interact = false

