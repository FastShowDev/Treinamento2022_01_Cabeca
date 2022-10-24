extends Sprite

var text:String = "Um baú com itens pode ser encontrado nas redondezas!"

onready var chat_bar = $"%DialogBar"
onready var ballom = $StaticBody2D

func _ready():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and ballom.is_player_close:
		chat_bar.set_dialog_bar_text(text)
		chat_bar.show_dialog_bar()
	
