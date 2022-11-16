extends Node2D

onready var audio: AudioStreamPlayer = $BackgroundFX
var can_play: bool = true

func _process(_delta: float) -> void:
	play_background_audio()
	
func play_background_audio() -> void:
	if can_play:
		can_play = false
		audio.play()

func _on_BackgroundFX_finished():
	can_play = true
