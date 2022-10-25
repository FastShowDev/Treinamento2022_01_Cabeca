# Takes care of loading or creating a new save game and provides appropriate
# resources to the user interface and the player.
extends Node2D

var map_name = ""
var _save := SaveGameAsJSON.new()

onready var _player := $YSort/Player
onready var _interface := $CanvasLayer/UserInterface

func _ready() -> void:
	_create_or_load_save()

# Toggles the inventory's visibility when pressing I.

func _create_or_load_save() -> void:
	if _save.save_exists():
		print("Carregando save!")
		_save.load_savegame()
	else:
		print("Criando save!")
		_save.map_name = map_name
		_save.write_savegame()

	# After creating or loading a save resource, we need to dispatch its data
	# to the various nodes that need it.
	_player.set_stats(_save.character)
	_interface.set_values(_save.character)
	
func _save_game() -> void:
	print("Salvando jogo!")
	_save.global_position = _player.global_position
	print(_player.global_position as String)
	_save.map_name = "Spawn"
	_save.character = _player.stats
	_save.write_savegame()


func _on_Spawn_tree_exiting():
	print("Saindo do jogo!")
	_save_game()