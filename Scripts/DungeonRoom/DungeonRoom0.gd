extends Node2D

onready var top_gate = $TopDungeonGate
onready var bottom_gate = $BottomDungeonGate
onready var left_gate = $LeftDungeonGate
onready var right_gate = $RightDungeonGate

func _ready():
	top_gate.set_dungeon_path("res://Scenes/DungeonRooms/DungeonRoom3.tscn")
	bottom_gate.set_dungeon_path("res://Scenes/SpawnScene.tscn")
	left_gate.set_dungeon_path("res://Scenes/DungeonRooms/DungeonRoom1.tscn")
	right_gate.set_dungeon_path("res://Scenes/DungeonRooms/DungeonRoom2.tscn")
	
	bottom_gate.open_gate()
