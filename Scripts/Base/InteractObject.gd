extends Sprite

var is_player_close: bool = false
var is_open: bool = false
var text: String = "Meu texto"
var title: String = "Meu título"

onready var interact_baloom = $StaticBody2D/InteractBaloom
onready var chat_bar = $"%DialogBar"

func _ready():
	interact_baloom.hide()
	
func _input(event):
	if event.is_action_pressed("interact_item") and is_player_close:
		chat_bar.set_dialog_bar_title(title)
		chat_bar.set_dialog_bar_text(text)
		chat_bar.show_dialog_bar()
		is_open = true
		
		
func _on_ChatDialog_confirmed():
	is_open = false
	

func _on_ChatDialog_about_to_show():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		interact_baloom.show()
		is_player_close = true
		

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		interact_baloom.hide()
		is_player_close = false
