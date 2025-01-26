extends ColorRect
class_name FadingRect

signal finished_fading
@export var start_black := false
@onready var tweening := false
@onready var my_tween : Tween = null

func _ready() -> void:
	color = Color(0, 0, 0, 0)
	print("my_color: ", color.a)
	if start_black:
		color.a = 1.0

func fade_to_black(tween_time):
	print("starting fade")
	tweening = true
	# FIXME
	my_tween = get_tree().create_tween()
	my_tween.tween_property(self, "color:a", 1.0, tween_time)
	await my_tween.finished
	finished_fading.emit()
	tweening = false

func fade_from_black(tween_time):
	print("starting fade")

	tweening = true
	# FIXME
	
	my_tween = get_tree().create_tween()
	my_tween.tween_property(self, "color:a", 0, tween_time)
	await my_tween.finished
	finished_fading.emit()
	tweening = false

func cancel_current_tween():
	if !tweening: return
	print("cancel fade")
	
	tweening = false
	my_tween.stop()
