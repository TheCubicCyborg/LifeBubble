extends Control

# filled with numbers, representing colors
## 0 = none, 1 = red
var grid = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(5):
		grid.append([])
		for j in range(5):
			grid[i].append(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
