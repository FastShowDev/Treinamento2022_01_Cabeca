class_name Dialog
extends Resource

var is_dialog_open: bool = false
var dialog_text: String = ""

func set_dialog_text(text:String) -> void:
	dialog_text =  text
	emit_changed()

func get_dialog_text() -> String:
	return dialog_text
