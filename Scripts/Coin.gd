extends AnimatedSprite

onready var anim = $AnimationPlayer

func _ready():
	pass
	
func _physics_process(delta):
	anim.play("idle")

func _on_Area2D_body_entered(body: KinematicBody2D):
	if body.name == "Player":
		body.collect_coin()
		queue_free()
