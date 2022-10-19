extends AnimatedSprite

onready var animation_player = $AnimationPlayer

func _ready():
	pass
	
func _physics_process(delta):
	animation_player.play("idle")

func _on_Area2D_body_entered(body: KinematicBody2D):
	if body.name == "Player":
		body.collect_heart()
		queue_free()
