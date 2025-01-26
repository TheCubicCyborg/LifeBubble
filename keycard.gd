extends Interactable
class_name collectible

@export var item_name:String
@export var texture: Texture2D
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	sprite.texture = texture
	collision_shape.shape.size = texture.get_size()

func interact():
	Globals.InventoryManager.pickup(item_name)
	queue_free()
