extends StaticBody2D

var is_player_close: bool = false
var is_open: bool = false
var text: String = "Meu texto"

onready var interact_baloom = $InteractBaloom

func _ready():
	interact_baloom.hide()
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("on")
		interact_baloom.show()
		is_player_close = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		interact_baloom.hide()
		is_player_close = false
