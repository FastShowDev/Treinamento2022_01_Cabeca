extends DungeonGate

const type: String = "LeftDungeonGate"
const path: String = "res://Models/Structures/Gates/LeftDungeonGate.tscn"
var dungeon_path: String
const aux_type: String = "LeftDungeonGate"


func _ready() -> void:
	load_gate()
	set_dungeon_data(dungeon_path, aux_type)


func set_data() -> void:
	set_dungeon_data(dungeon_path, aux_type)


func _on_scene_tree_exiting():
	pass # Replace with function body.
