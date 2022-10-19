extends KinematicBody2D

var speed = 175
var health = 100
var keys = 0
var interactDist = 20
var velocity = Vector2.ZERO

onready var animeted_sprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var collision = $AttackArea/CollisionShape2D

var can_attack: bool = false
var player_direction: Vector2 = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta: float) -> void:
	move()
	verify_direction()
	animate()
	#attack()

func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)

func verify_direction() -> void:
	if velocity.x > 0:
		player_direction = Vector2(1,0)
	elif velocity.x < 0:
		player_direction = Vector2(-1,0)
	elif velocity.y > 0:
		player_direction = Vector2(0,1)
	elif velocity.y < 0:
		player_direction = Vector2(0,-1)

func attack() -> void:
	pass
		

func animate() -> void:
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			animation.play("move_right")
		elif velocity.x < 0:
			animation.play("move_left")
		elif velocity.y > 0:
			animation.play("move_down")
		elif velocity.y < 0:
			animation.play("move_up")
	else:
		animation.stop()
		if player_direction.x == 1:
			animeted_sprite.play("idle_right")
		elif player_direction.x == -1:
			animeted_sprite.play("idle_left")
		elif player_direction.y == 1:
			animeted_sprite.play("idle_down")
		elif player_direction.y == -1:
			animeted_sprite.play("idle_up")
			
	
		
func play_animation(anim_name):
	pass
	

	
func on_animation_finished(anim_name):
	pass
