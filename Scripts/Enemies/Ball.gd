extends KinematicBody2D


func _ready():
	pass # Replace with function body.


func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		player_ref = body


func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		player_ref = null

