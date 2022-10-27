extends Control

var is_opened:bool = false
onready var bar = $ChatDialog

func _ready():
	#bar.window_title = ""
	#bar.dialog_text = "Inicializando chat..."
	pass

func set_dialog_bar_text(text: String) -> void:
	bar.dialog_text = text

func set_dialog_bar_title(text: String) -> void:
	bar.window_title = text

func show_dialog_bar() -> void:
	bar.show()
	is_opened = true
	
func hide_dialog_bar() -> void:
	bar.hide()
	is_opened = false

func _on_ChatDialog_confirmed():
	is_opened = false


func _on_ChatDialog_about_to_show():
	pass # Replace with function body.
