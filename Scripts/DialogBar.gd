extends Control

onready var bar = $ChatDialog

func _ready():
	bar.window_title = ""
	bar.dialog_text = "Inicializando chat..."

func set_dialog_bar_text(text: String) -> void:
	bar.dialog_text = text

func set_dialog_bar_tittle(text: String) -> void:
	bar.window_title = text

func show_dialog_bar() -> void:
	bar.show()
	
func hide_dialog_bar() -> void:
	bar.hide()
