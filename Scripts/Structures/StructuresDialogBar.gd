extends Sprite

var text:String = "Um baú com itens pode ser encontrado nas redondezas!"

onready var chat_bar = $"%DialogBar"
onready var baloom = $StaticBody2D

func _input(event: InputEvent):
	if event.is_action_pressed("interact_item") and baloom.is_player_close:
		chat_bar.set_dialog_bar_text(text)
		chat_bar.show_dialog_bar()
		print("eewdas")
	
