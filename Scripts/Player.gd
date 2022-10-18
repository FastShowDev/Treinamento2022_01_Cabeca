extends KinematicBody2D

var speed = 175
var health = 100
var keys = 0
var interactDist = 20
var velocity = Vector2.ZERO
var facingDir = Vector2.ZERO

onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite

func _ready():
	pass

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		facingDir = Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		facingDir = Vector2(0,1)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		facingDir = Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		facingDir = Vector2(1,0)
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed, Vector2.ZERO)
	
	if velocity.x > 0:
		play_animation("right")
	elif velocity.x < 0:
		play_animation("left")
	elif velocity.y > 0:
		play_animation("down")
	elif velocity.y < 0:
		play_animation("up")
	elif facingDir.x == 1:
		play_animation("idle_right")
	elif facingDir.x == -1:
		play_animation("idle_left")
	elif facingDir.y == 1:
		play_animation("idle_down")
	elif facingDir.y == -1:
		play_animation("idle_up")
		
func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)
