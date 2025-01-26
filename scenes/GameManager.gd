extends Node2D

var oxygen_remaining: float
@export var max_oxygen: float = 10
var in_bubble: bool = true
var refill_counter: int = 1
@export var refill_speed: float = 10
@onready var oxygen_bar = $CanvasLayer/ProgressBar
@onready var oxygen_timer_label = $CanvasLayer/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.GameManager = self
	oxygen_remaining = max_oxygen
	oxygen_bar.min_value = 0
	oxygen_bar.max_value = max_oxygen


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_bubble:
		if oxygen_remaining < max_oxygen:
			refill_oxygen(delta)
	else:
		if(oxygen_remaining > delta):
			oxygen_remaining -= delta
		else:
			oxygen_remaining = 0
	if oxygen_remaining <= 0:
		die()
	if(Input.is_action_just_pressed("Test")):
		oxygen_remaining = 5
	oxygen_bar.value = oxygen_remaining
	oxygen_timer_label.text = str(int(oxygen_remaining)) +  "s"

func enter_bubble(body:Node2D):
	in_bubble = true

func exit_bubble(body:Node2D):
	in_bubble = false
	refill_counter = 1

func refill_oxygen(delta):
	oxygen_remaining += refill_counter * delta * refill_speed
	refill_counter += 1
	if oxygen_remaining > max_oxygen:
		oxygen_remaining = max_oxygen

func die():
	print("die!")
