extends Area2D
class_name FadeArea

@export var modulator : MyCanvasModulate = null
@export var fadetime : float = 1
@export var entrance : bool = true

func _ready() -> void:
	if modulator == null:
		print("HEY !!! NO MODULATOR !!")
		return

func _on_area_entered(area: Area2D) -> void:
	if area is Interactor:
		# therefore its the player
		if entrance:
			modulator.enable_lighting(fadetime)
		else:
			modulator.disable_lighting(fadetime)
