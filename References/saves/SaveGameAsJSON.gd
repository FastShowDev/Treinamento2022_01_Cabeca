class_name SaveGameAsJSON
extends Reference

var SAVE_GAME_PATH : String = "C://Users//zlFas//Documents//Saves//save.json" 
const SAVE_PLAYER_DATA: String = "C://Users//zlFas//Documents//Saves//player.json" 

var version := 1

var enemies_data : Dictionary
var player_data : Dictionary
var gate_data : Dictionary
var itens_data : Dictionary
var all_data : Dictionary

var loading_room: bool
var room_name: String

var _file : File = File.new()


func save_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH) and _file.file_exists(SAVE_PLAYER_DATA)


func write_savegame() -> void:
	
	var error:= _file.open(SAVE_PLAYER_DATA, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" %
		[SAVE_PLAYER_DATA, error])
		return
	
	if player_data != null:
		var player_json := JSON.print(player_data)
		_file.store_string(player_json)
		_file.close()
	else:
		print("Could not open player data. Aborting save operation.")
		return
		
	error = _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return
	
	var data : Dictionary = {
		"Enemies": {},
		"Gates": {},
		"Instances": {},
	}
			
	if enemies_data != null:
		data["Enemies"] = enemies_data
	else:
		print("Could not open enemies data. Aborting save operation.")
		return
		
	if gate_data != null:
		data["Gates"] = gate_data
	else:
		print("Could not open gate data. Aborting save operation.")
		return
		
	if itens_data != null:
		data["Instances"] = itens_data
	else:
		print("Could not open itens data. Aborting save operation.")
		return
	
	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()


func load_savegame() -> void:
	var error := _file.open(SAVE_PLAYER_DATA, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" 
		% [SAVE_PLAYER_DATA, error])
		return
	var player_content : String = _file.get_as_text()
	var player_dict: Dictionary = {
		"Player": {},
	}
	player_dict["Player"] = player_content
	_file.close()
	all_data = JSON.parse(player_content).result

	error = _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return

	var content := _file.get_as_text()
	_file.close()

	all_data.merge(JSON.parse(content).result)
	
func read_player_data() -> Dictionary:
	var error := _file.open(SAVE_PLAYER_DATA, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" 
		% [SAVE_PLAYER_DATA, error])
		return {}
	var player_content : String = _file.get_as_text()
	var player_dict: Dictionary = {
		"Player": {},
	}
	player_dict["Player"] = player_content
	_file.close()
	return player_dict
