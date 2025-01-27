extends CanvasModulate
class_name MyCanvasModulate

@onready var tweening := false
@onready var my_black_tween : Tween = null
@onready var my_white_tween : Tween = null
@export var light : Light2D = null
@onready var lighting_enabled : bool = false

@export var the_darkness : TileMapLayer = null
@onready var my_darkness_tween : Tween = null


signal finished_fading

func _ready():
	visible = true
	if light == null:
		print("NO LIGHT")
	if the_darkness == null:
		print("NO DARKNESS")
	#await get_tree().create_timer(5).timeout
	#print("starting")
	#fade_to_black(1)
	

func fade_to_black(tween_time):
	print("starting fade")
	lighting_enabled = true
	tweening = true
	# FIXME
	my_black_tween = get_tree().create_tween()
	my_black_tween.tween_property(self, "color", Color.BLACK, tween_time)
	
	my_white_tween = get_tree().create_tween()
	my_white_tween.tween_property(light, "color:a", 1.0, tween_time)
	
	my_darkness_tween = get_tree().create_tween()
	my_darkness_tween.tween_property(the_darkness, "modulate:a", 0.0, tween_time)
	
	await my_black_tween.finished
	await my_white_tween.finished
	await my_darkness_tween.finished
	
	finished_fading.emit()
	tweening = false

func fade_from_black(tween_time):
	lighting_enabled = false
	print("starting fade")
	tweening = true
	# FIXME
	
	my_black_tween = get_tree().create_tween()
	my_black_tween.tween_property(self, "color", Color.WHITE, tween_time)
	
	my_white_tween = get_tree().create_tween()
	my_white_tween.tween_property(light, "color:a", 0.0, tween_time)
	
	my_darkness_tween = get_tree().create_tween()
	my_darkness_tween.tween_property(the_darkness, "modulate:a", 1.0, tween_time)
	
	await my_black_tween.finished
	await my_white_tween.finished
	await my_darkness_tween.finished
	finished_fading.emit()
	tweening = false

func enable_lighting(time):
	if not lighting_enabled:
		fade_to_black(time)
	
func disable_lighting(time):
	if lighting_enabled:
		fade_from_black(time)
