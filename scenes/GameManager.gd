extends Node2D

var oxygen_remaining: float
@export var max_oxygen: float


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.GameManager = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Globals.GameManager.max_oxygen)
