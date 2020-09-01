extends Node

var game_started : bool = false
var tutorial_shown : bool = false

var audio_volume : float = 0 setget set_audio_volume


func set_audio_volume(value):
	audio_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

