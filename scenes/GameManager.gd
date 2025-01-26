extends Node2D

var oxygen_remaining: float
@export var max_oxygen: float = 10
@export var fade_threshold: float = 3
var in_bubble: bool = true
var refill_counter: int = 1
@export var refill_speed: float = 10
@onready var oxygen_bar = $CanvasLayer/ProgressBar
@onready var oxygen_timer_label = $CanvasLayer/Label
@export var num_breakers = 10
var breakers : Array[bool]
@export var my_dude : FadingRect
var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.GameManager = self
	oxygen_remaining = max_oxygen
	oxygen_bar.min_value = 0
	oxygen_bar.max_value = max_oxygen
	oxygen_bar.visible = true
	breakers.resize(num_breakers)
	breakers.fill(false)
	my_dude.color.a = 1.0
	my_dude.fade_from_black(3)


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
	if oxygen_remaining <= fade_threshold:
		begin_fading()
	if oxygen_remaining <= 0:
		die()
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
	if my_dude.tweening:
		my_dude.cancel_current_tween()
		my_dude.fade_from_black(1)

func begin_fading():
	if !my_dude.tweening:
		my_dude.fade_to_black(3)


func die():
	print("die!")
	set_process(false)
	#my_dude.finished_fading.connect(reload_scene)
	#my_dude.fade_to_black()
	reload_scene()

func reload_scene():
	get_tree().reload_current_scene()

func openLaboratory():
	print("laboratory opened")
