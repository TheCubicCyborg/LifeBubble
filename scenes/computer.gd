extends Interactable
class_name Computer

@onready var puzzle = $CanvasLayer/PasswordPuzzle

func interact():
	puzzle.launch()
