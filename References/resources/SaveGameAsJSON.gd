class_name SaveGameAsJSON
extends Reference

const SAVE_GAME_PATH := "C://Users//zlFas//Documents//Saves//save.json"

var version := 1

var character: Resource = Character.new()

var map_name := ""
var global_position :Vector2

var _file := File.new()


func save_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH)


func write_savegame() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return
	print(global_position as String)
	print("Posicao ao salvar!")
	var data := {
		"global_position":
		{
			"x": global_position.x,
			"y": global_position.y,
		},
		"map_name": map_name,
		"player":
		{
			"display_name": character.display_name,
			"speed": character.speed,
			"max_hearts": character.max_hearts,
			"hearts": character.hearts,
			"bombs": character.bombs,
			"coins": character.coins,
			"keys": character.keys,
		},
	}
	
	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()


func load_savegame() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return

	var content := _file.get_as_text()
	_file.close()

	var data: Dictionary = JSON.parse(content).result
	character = Character.new()
	character.global_position = Vector2(data.global_position.x, data.global_position.y)
	map_name = data.map_name
	print("A posicao do personagem: x = " + data.global_position.x as String + " y = " + data.global_position.y as String)
	character.display_name = data.player.display_name
	character.speed = data.player.speed
	character.max_hearts = data.player.max_hearts
	character.keys = data.player.keys
	character.bombs = data.player.bombs
	character.hearts = data.player.hearts
	character.coins = data.player.coins
	
	
