extends Interactable
class_name cracked_wall

@export var crack_position: Vector2

func interact():
	if Globals.InventoryManager.found["crowbar"]:
		Globals.GameManager.tilemap_collidable.set_cell(crack_position,-1)
