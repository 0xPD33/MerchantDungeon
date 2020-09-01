extends Popup

var settings_shown = false

onready var settings_panel = $MenuBackground/SettingsPanel
onready var audio_slider = $MenuBackground/SettingsPanel/MarginContainer/VBoxContainer/AudioSlider

onready var anim_player = $AnimationPlayer


func set_pause(value):
	get_tree().paused = value


func _ready():
	audio_slider.value = Global.audio_volume


func open():
	show()
	$MenuBackground/MarginContainer/ButtonContainer/ContinueButton.grab_focus()
	set_pause(true)


func close():
	set_pause(false)
	hide()


func show_settings():
	anim_player.play("show_settings")
	yield(anim_player, "animation_finished")
	settings_shown = true


func hide_settings():
	anim_player.play("hide_settings")
	yield(anim_player, "animation_finished")
	settings_shown = false


func toggle_settings():
	if !settings_shown:
		show_settings()
	else:
		hide_settings()


func _on_ContinueButton_pressed():
	if settings_shown:
		hide_settings()
	close()


func _on_RestartButton_pressed():
	close()
	get_tree().reload_current_scene()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	toggle_settings()


func _on_AudioSlider_value_changed(value: float):
	Global.set_audio_volume(value)


func _on_AudioOn_pressed():
	audio_slider.value = audio_slider.max_value


func _on_AudioOff_pressed():
	audio_slider.value = audio_slider.min_value
