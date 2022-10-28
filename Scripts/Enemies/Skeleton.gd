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

var timer_on = false
var time = 86395

var rng = RandomNumberGenerator.new()

func resetTimer() -> void:
	time = 0
	pass

func startTimer() -> void:
	timer_on = true
	pass
	
func stopTimer() -> void:
	timer_on = false
	pass
	
func updateTimer(delta) -> void:
	if(timer_on):
		time += delta
	

func geraSentido() -> String:
	
	rng.randomize()
	var rn = rng.randi_range ( 0, 3 )
	var sentido = null
	
	if(rn == 0):
		sentido = 'right'
	elif(rn == 1):
		sentido = 'left'
	elif(rn == 2):
		sentido = 'up'
	elif(rn == 3):
		sentido = 'down'
		
	return sentido

func _physics_process(delta: float) -> void:
	
	var sentido = geraSentido()
	
	updateTimer(delta)
	
	if(timer_on):
		if(time >= 2):	
			
			sentido = geraSentido()
			trocaSentido(sentido)
			animate()
			resetTimer()
	else:
		startTimer()
		
	move()	
	
	
func trocaSentido(direction: String) -> void:
	
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
	
	
func move()->void:
	
	velocity.x = speed * move_direction_x
	velocity = move_and_slide(velocity)
	
	velocity.y = speed * move_direction_y
	velocity = move_and_slide(velocity)
	
	

func animate()->void:
	
#	if velocity != Vector2.ZERO:
		
	if move_direction_y == 1:
		animation.play("walkingDown")
		return
	elif(move_direction_y == -1):
		animation.play("walkingUp")
		return
	elif move_direction_x == 1:
		animation.play("walkingRight")
		return
	elif(move_direction_x == -1):
		animation.play("walkingLeft")
		return
		
	else:
		pass
	
#		if lado == "down":
#			animation.play("stopDown")
#			return
#		elif lado == "up":
#			animation.play("stopUp")
#			return
#		elif lado == "right":
#			animation.play("stopRight")
#			return
#		elif lado == "left":
#			animation.play("stopLeft")
#			return
		

	
	
	
