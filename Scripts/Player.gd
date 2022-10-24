extends KinematicBody2D

#Stats + itens
var max_hearts: int = 6
var hearts: int = 2
var keys: int  = 0
var coins: int = 0
var bombs: int = 0

#Player physics
var speed = 175
var velocity = Vector2.ZERO

#Components:
onready var animated_sprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var collision = $AttackArea/CollisionShape2D
onready var ui = $"%UserInterface"
onready var bar = $"%DialogBar"

export var BOMB: PackedScene

#Permissions:
var can_attack: bool = false
var player_direction: Vector2 = Vector2.ZERO


func _ready():
	#ui.set_coin_value(coins)
	#ui.set_heart_value(hearts)
	#ui.set_bomb_value(bombs)
	pass

func _process(delta: float) -> void:
	#print("Vida atual: " + hearts as String)
	pass


func _physics_process(delta: float) -> void:
	move()
	attack()
	verify_direction()
	animate()
	use_bomb()
	#print("Numero de bombas: " + bombs as String)
	
	
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
	if Input.is_action_just_pressed("attack") and not can_attack and not bar.is_opened:
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
			animated_sprite.play("idle_right")
		elif player_direction.x == -1:
			animated_sprite.play("idle_left")
		elif player_direction.y == 1:
			animated_sprite.play("idle_down")
		elif player_direction.y == -1:
			animated_sprite.play("idle_up")
			
			
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


func collect_heart() -> void:
	if hearts >= max_hearts:
		return
	else:
		hearts += 1
		ui.set_heart_value(hearts)
		
func collect_coin() -> void:
	coins += 1
	ui.set_coin_value(coins)

#Bomb functions:
func collect_bomb() -> void:
	print("Coletei!")
	bombs += 1
	ui.set_bomb_value(bombs)
	
	
func use_bomb() -> void:
	if Input.is_action_just_pressed("use_item") and bombs > 0:
		print("Usando bomba!")
		bombs -= 1
		ui.set_bomb_value(bombs)
		var bomb = BOMB.instance()
		get_parent().add_child(bomb)
		get_parent().call_deferred("add_child", bomb)
		bomb.exploding = true
		bomb.scale.x = 1
		bomb.scale.y = 1
		bomb.position = global_position
		bomb.explode()


func update_key_score(key: int) -> void:
	pass


func collect_key() -> void:
	keys += 1
	update_key_score(1)
