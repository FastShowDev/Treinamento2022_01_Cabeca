extends KinematicBody2D
#
#O comportamento de esqueleto é:
#	1: escolhe um lado "s"
#	2: escolhe quantos "t" segundos vai andar
#	3: anda "t" segundo para o lado "s"
#	4: volta ao passo "1"

onready var animation: AnimationPlayer = get_node("Animation")

export var speed = 55
export var health = 1 
var velocity = Vector2.ZERO
var move_direction_x = -1
var move_direction_y = 1
var lado = "down"

func _physics_process(delta: float) -> void:
	
	move('right')
	animate()
	
func move(direction: String)->void:
	
	if(direction == 'down'):
		move_direction_x = 0
		move_direction_y = 1
	elif(direction == 'up'):
		move_direction_x = 0
		move_direction_y = -1
	elif(direction =='right'):
		move_direction_x = 1
		move_direction_y = 0
	elif(direction == 'left'):
		move_direction_x = -1
		move_direction_y = 0
	
	velocity.x = speed * move_direction_x
	velocity = move_and_slide(velocity)
	
	velocity.y = speed * move_direction_y
	velocity = move_and_slide(velocity)
	
	

func animate()->void:
	
	if velocity != Vector2.ZERO:
		
		if move_direction_y == 1:
			animation.play("walkingDown")
			return
		elif(move_direction_y == -1):
			animation.play("walkingUp")
			return
		
		if move_direction_x == 1:
			animation.play("walkingRight")
			return
		elif(move_direction_x == -1):
			animation.play("walkingLeft")
			return
		
	else:
	
		if lado == "down":
			animation.play("stopDown")
		elif lado == "up":
			animation.play("stopUp")
		elif lado == "right":
			animation.play("stopRight")
		elif lado == "left":
			animation.play("stopLeft")
		

	
	
	
