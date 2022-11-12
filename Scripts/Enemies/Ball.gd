extends KinematicBody2D

const path: String = "res://Models/Enemies/Ball.tscn"

func _ready():
	pass # Replace with function body.


func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		pass


func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		pass

