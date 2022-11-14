# Takes care of loading or creating a new save game and provides appropriate
# resources to the user interface and the player.
extends Node2D
class_name LoadGame

var save_game_path: String

var _save := SaveGameAsJSON.new()
signal save_completed

var top_dungeon_path : String 
var bottom_dungeon_path : String 
var right_dungeon_path : String 
var left_dungeon_path : String
var open_std_gate: String
var std_gate_values: Array
 
var new_game: bool = false
var loading_room: bool = false
var door_type: String
var room_start_positions : Array
var start_position: Vector2

onready var _player : KinematicBody2D = $"%Player"
onready var _interface := $Interfaces/UserInterface
onready var _bar := $Interfaces/DialogBar


func set_save_path(path: String) -> void:
	save_game_path = path
	_save.SAVE_GAME_PATH = save_game_path


# Toggles the inventory's visibility when pressing I.
func _create_or_load_save() -> void:
	
	if _save.save_exists():
		print("Carregando save!")
		_save.load_savegame()
	else:
		print("Criando save!")
		_load_new_game()
		_save_game()
		return
			
		# After creating or loading a save resource, we need to dispatch its data
		# to the various nodes that need it.
	print("Carregando dados:")
	_load_game(_save.all_data)
		#_interface.set_values(_save.character)
	
	
func _save_game() -> void:
	#_save.loading_room = self.loading_room
	print("Salvando jogo!")
	_save_player_data()
	_save_enemies_data()
	_save_map_data()
	_save.write_savegame()


func _on_scene_tree_exiting():
	print("Saindo do jogo!")
	_save_game()
	print("Acabouu")


func _save_player_data() -> void:
	var stats: Character = _player.get_actual_stats()
	var player_data: Dictionary = {
		"Player": {
				"x": stats.global_position.x,
				"y": stats.global_position.y,
				"speed": stats.speed,
				"max_hearts": stats.max_hearts,
				"hearts": stats.hearts,
				"bombs": stats.bombs,
				"coins": stats.coins,
				"keys": stats.keys,
			},
	}
	if loading_room:
		print(room_start_positions)
		print(door_type)
		match door_type:
			"TopDungeonGate":
				start_position = room_start_positions[0]
			"BottomDungeonGate":
				start_position = room_start_positions[1]
			"RightDungeonGate":
				start_position = room_start_positions[2]
			"LeftDungeonGate":
				start_position = room_start_positions[3]
				
		player_data["Player"]["x"] = start_position.x
		player_data["Player"]["y"] = start_position.y
		print(start_position)
	_save.player_data = player_data


func _save_enemies_data() -> void:
	var enemies_nodes = get_node("Enemies").get_children()
	var enemies_data : Dictionary = {}
	
	for enemy in enemies_nodes:
		var new_enemy : Dictionary = {
			enemy.name : {
				"x": enemy.global_position.x,
				"y": enemy.global_position.y,
				"path": enemy.path,
				#"type": enemy.type,
			} 
		}
		enemies_data.merge(new_enemy)
		
	_save.enemies_data = enemies_data


func _save_map_data() -> void:
	var gate_nodes = get_node("Gates").get_children()
	var gate_data : Dictionary = {}
	for gate in gate_nodes:
		var new_gate: Dictionary = {
			gate.name: {
				"x": gate.global_position.x,
				"y": gate.global_position.y,
				"path": gate.path,
				#"next_dungeon": gate.dungeon_path,
				"type": gate.type,
				"open": gate.is_open
			}
		}
		gate_data.merge(new_gate)
	_save.gate_data = gate_data
	
	var instances_nodes = get_node("Instances").get_children()
	var itens_data : Dictionary = {}
	for instance in instances_nodes:
		var new_instance: Dictionary = {
			instance.name: {
				"x": instance.global_position.x,
				"y": instance.global_position.y,
				"path": instance.path,
				#"type": instance.type,
			}
		}
		itens_data.merge(new_instance)
	_save.itens_data = itens_data


func _load_game(data: Dictionary) -> void:
	print("Dados lidos: ")
	print(data["Player"])
	_player.load_stats(data["Player"])
	_interface.set_values(_player.stats)
	
	var old_gates = get_node("Gates").get_children()
	for old in old_gates:
		old.queue_free()
		
	for new in data["Gates"].values():
		var new_gate = load(new["path"]).instance()
		new_gate.name = new["type"]
		match new_gate.name:
			"TopDungeonGate":
				new_gate.dungeon_path = top_dungeon_path
			"BottomDungeonGate":
				new_gate.dungeon_path = bottom_dungeon_path
			"RightDungeonGate":
				new_gate.dungeon_path = right_dungeon_path
			"LeftDungeonGate":
				new_gate.dungeon_path = left_dungeon_path
		
		new_gate.position = Vector2(new["x"], new["y"])
		new_gate.is_open = new["open"]
		new_gate.scale.x = 4
		new_gate.scale.y = 4
		get_node("Gates").add_child(new_gate)
	
	var old_itens = get_node("Instances").get_children()
	for old in old_itens:
		old.queue_free()
	
	for new in data["Instances"].values():
		var new_item = load(new["path"]).instance()
		new_item.position = Vector2(new["x"], new["y"])
		get_node("Instances").add_child(new_item)
	
	var old_enemies = get_node("Enemies").get_children()
	for old in old_enemies:
		old.queue_free()
	
	for new in data["Enemies"].values():
		var new_enemy = load(new["path"]).instance()
		new_enemy.position = Vector2(new["x"], new["y"])
		get_node("Enemies").add_child(new_enemy)


func _load_new_game() -> void:
	var gates = get_node("Gates").get_children()
	for new_gate in gates:
		match new_gate.name:
			"TopDungeonGate":
				new_gate.dungeon_path = top_dungeon_path
				if std_gate_values[0]:
					new_gate.is_open = true
					
			"BottomDungeonGate":
				new_gate.dungeon_path = bottom_dungeon_path
				if std_gate_values[1]:
					new_gate.is_open = true
					
			"RightDungeonGate":
				new_gate.dungeon_path = right_dungeon_path
				if std_gate_values[2]:
					new_gate.is_open = true
					
			"LeftDungeonGate":
				new_gate.dungeon_path = left_dungeon_path
				if std_gate_values[3]:
					new_gate.is_open = true
					
		#new_gate.is_open = true
		new_gate.set_data()	
	
	
	
	
	
