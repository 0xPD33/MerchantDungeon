extends Node2D

export (PackedScene) var linked_weapon
export (String) var weapon_description

var player

var actual_weapon_name
var damage

var can_take = false

onready var drop_panel = $DropPanel


func get_damage():
	var linked_instance = linked_weapon.instance()
	if linked_instance.is_in_group("MeleeWeapon"):
		damage = linked_instance.attack_damage
	elif linked_instance.is_in_group("MagicWeapon"):
		damage = linked_instance.projectile_damage


func set_actual_name():
	var actual_name = name.trim_suffix("Drop")
	actual_weapon_name = actual_name.capitalize()


func setup():
	var setup_done = false
	get_damage()
	set_actual_name()
	drop_panel.setup()
	setup_done = true


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")
	setup()


func _input(_event):
	if Input.is_action_just_pressed("interact") and can_take and player != null:
		take_weapon()


func take_weapon():
	player.call("equip_weapon", linked_weapon.instance())
	self.queue_free()


func _on_PickupRadius_body_entered(body: Node):
	if body.is_in_group("Player"):
		can_take = true


func _on_PickupRadius_body_exited(body: Node):
	if body.is_in_group("Player"):
		can_take = false

