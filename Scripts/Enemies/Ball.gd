extends KinematicBody2D

const path: String = "res://Models/Enemies/Ball.tscn"

onready var ray_up: RayCast2D = $rayCast/up
onready var ray_down: RayCast2D = $rayCast/down
onready var ray_right: RayCast2D = $rayCast/right
onready var ray_left: RayCast2D = $rayCast/left

var speed: int = 250
var direction_vector: Vector2
var velocity: Vector2


func _ready() -> void:
	if ray_up.is_colliding():
		if ray_right.is_colliding():
			direction_vector = Vector2(0, 1)
		else:
			direction_vector = Vector2(1, 0)
	elif ray_down.is_colliding():
		if ray_right.is_colliding():
			direction_vector = Vector2(-1, 0)
		else:
			direction_vector = Vector2(0, -1)
	elif ray_right.is_colliding():
		direction_vector = Vector2(0, 1)
	elif ray_left.is_colliding():
		direction_vector = Vector2(0, -1)

func _physics_process(delta) -> void:
	move()
	verify_direction()


func move() -> void:
	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)


func verify_direction() -> void:
	if ray_up.is_colliding():
		if ray_right.is_colliding():
			direction_vector = Vector2(0, 1)
		else:
			direction_vector = Vector2(1, 0)
	elif ray_down.is_colliding():
		if ray_left.is_colliding():
			direction_vector = Vector2(0, -1)
		else:
			direction_vector = Vector2(-1, 0)
	elif ray_right.is_colliding():
		if ray_down.is_colliding():
			direction_vector = Vector2(-1, 0)
		else:
			direction_vector = Vector2(0, 1)
	elif ray_left.is_colliding():
		if ray_up.is_colliding():
			direction_vector = Vector2(1, 0)
		else:
			direction_vector = Vector2(0, -1)
