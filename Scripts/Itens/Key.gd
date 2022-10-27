extends AnimatedSprite

onready var anim = $KeyAnimationPlayer

func _ready():
	pass
	
func _physics_process(delta):
	anim.play("idle")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.collect_key()
		queue_free()
