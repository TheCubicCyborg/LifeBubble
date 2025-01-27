extends Area2D
class_name Interactable

@export var breaker_id : int

func interact():
	print("INTERACT WITH BREAKER ", breaker_id)
	if breaker_id == -1:
		return
	Globals.GameManager.breakers[breaker_id] = true
