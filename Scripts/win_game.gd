extends Node2D

onready var win_sound: AudioStreamPlayer = get_parent().get_node("Background").get_node("WinFX")
onready var win_chest: AnimatedSprite = get_node("Chest")
export(PackedScene) var win_text

var open_chest: bool = false
var rodou: bool = true

func _process(delta: float):
	open_chest = win_chest.is_open
	print(win_chest.is_open)
	if open_chest and rodou:
		end_game()

func end_game() -> void:
	var _text: WinText = win_text.instance()
	win_sound.play()
	get_tree().root.call_deferred("add_child", _text)
	print("É")
	rodou = false
