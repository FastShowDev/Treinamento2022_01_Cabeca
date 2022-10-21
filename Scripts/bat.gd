extends KinematicBody2D
#
#Esse inimigo tem uma tragetória simples,
#ele apenas voa aleatóriamente e, ao colidir 
#com o cenário, ele muda de direção

export var speed = 55
export var health = 1 
var velocity = Vector2.ZERO
var move_direction_x = -1
var move_direction_y = 1

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction_x
	velocity = move_and_slide(velocity)
	
	velocity.y = speed * move_direction_y
	velocity = move_and_slide(velocity)
	
	if move_direction_x == 1:
		$texture.flip_h = true
	else:
		$texture.flip_h = false
		
		
	
	if $ray_wall_x.is_colliding():
		$texture.flip_h != $texture.flip_h
		$ray_wall_x.scale.x *= -1
		move_direction_x *= -1
		move_direction_y *= -1
		$ray_wall_y.scale *= -1

	if $ray_wall_y.is_colliding():
		$ray_wall_y.scale *= -1
		move_direction_x *= 1
		move_direction_y *= -1
#
		

	
	
	
