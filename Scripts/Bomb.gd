extends AnimatedSprite

var exploding: bool = false
onready var bomb_anim = $BombAnimation

func _ready():
	pass
	
func _physics_process(delta):
	bomb_anim.play("idle")
	
	
func explode():
	set_physics_process(false)
	bomb_anim.stop()
	bomb_anim.play("explode")
	queue_free()
	
func _on_Area2D_body_entered(body):
	if body.name == "Player" and not exploding:
		body.collect_bomb()
		queue_free()
