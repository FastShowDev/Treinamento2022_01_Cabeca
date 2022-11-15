extends LoadGame
class_name SetupGame

const save_path: String = "C://Users//zlFas//Documents//Saves//"
var suffix: String

func _ready() -> void:
	print("Estou na cena: " + self.name)
	match self.name:
		"DungeonRoom0":
			suffix = "room0.json"
			self.top_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom3.tscn"
			self.bottom_dungeon_path = "res://Scenes/SpawnScene.tscn"
			self.left_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom1.tscn"
			self.right_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom2.tscn"
			self.room_start_positions = [Vector2(512,570), Vector2(687,186), 
				Vector2(50,320), Vector2(975, 320)]
			self.std_gate_values = [false, true, true, true]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom1":
			suffix = "room1.json"
			self.right_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom0.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(0,0), 
				Vector2(50, 320), Vector2(0,0)]
			self.open_std_gate = "RightDungeonGate"
			self.std_gate_values = [false, false, true, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom2":
			suffix = "room2.json"
			self.left_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom0.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(0,0), 
				Vector2(0, 0), Vector2(975,320)]
			self.open_std_gate = "LeftDungeonGate"
			self.std_gate_values = [false, false, false, true]
			self.drop_ammount = [1,1,1,1] #[heart, bomb, key, coin]
				
		"DungeonRoom3":
			suffix = "room3.json"
			self.top_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom4.tscn"
			self.bottom_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom0.tscn"
			self.room_start_positions = [Vector2(512,570), Vector2(512,70), 
				Vector2(0, 0), Vector2(0,0)]
			self.open_std_gate = "BottomDungeonGate"
			self.std_gate_values = [true, true, false, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
				
		"DungeonRoom4":
			suffix = "room4.json"
			self.right_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom5.tscn"
			self.bottom_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom3.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(512,70), 
				Vector2(70, 320), Vector2(0,0)]
			self.open_std_gate = "BottomDungeonGate"
			self.std_gate_values = [false, true, true, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom5":
			suffix = "room5.json"
			self.top_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom7.tscn"
			self.left_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom4.tscn"
			self.room_start_positions = [Vector2(512,570), Vector2(0,0), 
				Vector2(0, 0), Vector2(975,320)]
			self.open_std_gate = "LeftDungeonGate"
			self.std_gate_values = [true, false, false, true]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom6":
			suffix = "room6.json"
			self.bottom_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom7.tscn"
			self.right_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom8.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(512,70), 
				Vector2(70, 320), Vector2(0,0)]
			self.open_std_gate = "BottomDungeonGate"
			self.std_gate_values = [false, true, true, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom7":
			suffix = "room7.json"
			self.top_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom6.tscn"
			self.bottom_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom5.tscn"
			self.room_start_positions = [Vector2(512,570), Vector2(512,70), 
				Vector2(0, 0), Vector2(0,0)]
			self.open_std_gate = "BottomDungeonGate"
			self.std_gate_values = [true, true, false, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom8":
			suffix = "room8.json"
			self.top_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom9.tscn"
			self.left_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom6.tscn"
			self.room_start_positions = [Vector2(512,570), Vector2(0,0), 
				Vector2(0, 0), Vector2(975,320)]
			self.open_std_gate = "LeftDungeonGate"
			self.std_gate_values = [false, false, false, true]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom9":
			suffix = "room9.json"
			self.bottom_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom8.tscn"
			self.right_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom10.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(512,70), 
				Vector2(70, 320), Vector2(0,0)]
			self.open_std_gate = "BottomDungeonGate"
			self.std_gate_values = [false, true, true, false]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
		"DungeonRoom10":
			suffix = "room10.json"
			self.left_dungeon_path = "res://Scenes/DungeonRooms/DungeonRoom9.tscn"
			self.room_start_positions = [Vector2(0,0), Vector2(0,0), 
				Vector2(0, 0), Vector2(975,320)]
			self.open_std_gate = "LeftDungeonGate"
			self.std_gate_values = [false, false, false, true]
			self.drop_ammount = [] #[heart, bomb, key, coin]
			
	var save_game_path: String = save_path + suffix
	print("Game_Path:" + save_game_path)
	set_save_path(save_game_path)
	_create_or_load_save()

