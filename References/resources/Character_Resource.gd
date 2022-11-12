class_name Character
extends Resource

#Path:
export var path: String = "res://Models/Player.tscn"

#Player stats:
export var max_hearts: float = 6
export var hearts: float = 2
export var keys: float  = 10
export var coins: float = 0
export var bombs: float = 0
export var display_name: String = "FastShow-Player"

#Player physics
export var speed = 175
export var velocity = Vector2.ZERO
export var global_position: Vector2
