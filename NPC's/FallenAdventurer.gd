extends KinematicBody2D

var player = null

var can_interact = false
var appeared = false

var dialogue_state = 0
var introduced = false

onready var anim_player = $AnimationPlayer
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
	dialogue_panel.npc = self
	
	if !introduced:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogue_panel.dialogue = "..."
				dialogue_panel.answers = "[E] - Hey you!"
				show_dialogue()
			1:
				match answer:
					"A":
						dialogue_state = 2
						dialogue_panel.dialogue = "Beware the merchant!"
						dialogue_panel.answers = "[E] - What merchant?"
						show_dialogue()
			2:
				match answer:
					"A":
						dialogue_state = 3
						dialogue_panel.dialogue = "You will meet him soon.\nHe showed me his evil form when I first met him."
						dialogue_panel.answers = "[E] - Why do you think he's evil?"
						show_dialogue()
			3:
				match answer:
					"A":
						dialogue_state = 4
						dialogue_panel.dialogue = "Adventurers end up here all the time. People just like you and me.\nEvery single one before you has fallen. He is not on your side!"
						dialogue_panel.answers = "[E] - Thank you for telling me."
						show_dialogue()
			4:
				match answer:
					"A":
						dialogue_state = 5
						dialogue_panel.dialogue = "Now go, take revenge on him for all the lost souls like me!"
						dialogue_panel.answers = "[E] - I will."
						show_dialogue()
			5:
				match answer:
					"A":
						dialogue_state = 0
						dialogue_panel.hide()
						introduced = true
						can_interact = false
	else:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogue_panel.dialogue = "What are you still doing here?"
				dialogue_panel.answers = "[E] - I have to get going."
				show_dialogue()
			1:
				match answer:
					"A":
						dialogue_state = 2
						dialogue_panel.dialogue = "Yes, you have to. Goodbye."
						dialogue_panel.answers = "[E] - Goodbye!"
						show_dialogue()
			2:
				match answer:
					"A":
						dialogue_state = 0
						dialogue_panel.hide()
						can_interact = false


func _on_InteractRange_body_entered(body: Node):
	if body.is_in_group("Player") and !appeared:
		anim_player.play("appear")
		yield(anim_player, "animation_finished")
		appeared = true
		can_interact = true


func _on_InteractRange_body_exited(body: Node):
	if body.is_in_group("Player") and appeared:
		anim_player.play("disappear")
		yield(anim_player, "animation_finished")
		appeared = false
		can_interact = false
		dialogue_state = 0
		dialogue_panel.hide()

