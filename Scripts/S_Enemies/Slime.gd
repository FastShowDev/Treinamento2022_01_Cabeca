extends KinematicBody2D

var player_ref = null
var speed: int = 100
var velocity: Vector2

onready var slime_animation = $SlimeAnimationPlayer
onready var sprite = $Sprite

var can_die:bool = false

func _ready():
	pass

func _physics_process(delta: float) -> void:
	move()
	animate()
	verify_direction()
	
	
func move() -> void:
	if player_ref != null:
		var distance: Vector2 = player_ref.position - global_position
		var direction: Vector2 = distance.normalized()
		var distance_length: float = distance.length()
		if distance_length < 5:
			velocity = Vector2.ZERO
		else:
			velocity = speed * direction
	else:
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity)

func animate() -> void:
	if can_die:
		slime_animation.stop()
		slime_animation.play("dead")
		set_physics_process(false)
		yield(slime_animation, "animation_finished")
		queue_free()
	elif velocity != Vector2.ZERO:
		slime_animation.play("walk")
	else:
		slime_animation.play("idle")

func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		player_ref = body


func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		player_ref = null

func _on_CollisionArea_area_entered(area):
	if area.is_in_group("player_attack") or area.is_in_group("bomb_explosion"):
		can_die = true
	
