extends DungeonGate

const type: String = "RightDungeonGate"
const path: String = "res://Models/Structures/Gates/RightDungeonGate.tscn"
var dungeon_path: String
const aux_type: String = "RightDungeonGate"


func _ready() -> void:
	load_gate()
	set_dungeon_data(dungeon_path, aux_type)
	
	
func set_data() -> void:
	set_dungeon_data(dungeon_path, aux_type)
