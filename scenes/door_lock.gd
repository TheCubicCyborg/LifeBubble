extends Interactable
class_name DoorLock

@onready var door = $".."

func interact():
	door.unlock()
