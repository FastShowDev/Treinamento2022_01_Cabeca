extends KinematicBody2D

#Stats
var max_hearts: int = 4
var keys: int  = 0
var hearts: int = 2

#Player physics
var speed = 175
var velocity = Vector2.ZERO

#Components:
onready var animeted_sprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var collision = $AttackArea/CollisionShape2D

#Permissions:
var can_attack: bool = false
var player_direction: Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(delta: float) -> void:
	print("Vida atual: " + hearts as String)

func _physics_process(delta: float) -> void:
	move()
	attack()
	verify_direction()
	animate()
	
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
	if Input.is_action_just_pressed("attack") and not can_attack:
		can_attack = true


func animate() -> void:
	if can_attack:
		if player_direction.x == 1:
			animation.play("attack_right")
		if player_direction.x == -1:
			animation.play("attack_left")
		if player_direction.y == 1:
			animation.play("attack_down")
		if player_direction.y == -1:
			animation.play("attack_up")
		set_physics_process(false)
	elif velocity != Vector2.ZERO:
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
	
func on_animation_finished():
	
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if can_attack:
		set_physics_process(true)
		can_attack = false
	pass # Replace with function body.

func increase_max_heart() -> void:
	max_hearts += 1

func update_heart_values(heart_value: int) -> void:
	pass

func collect_heart() -> void:
	if hearts >= max_hearts:
		return
	else:
		hearts += 1
		update_heart_values(hearts)
		
