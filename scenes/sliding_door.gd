extends StaticBody2D


@onready var door_collider : CollisionShape2D = $DoorCollider
@export var slide_door_anim : AnimationPlayer
@export var locked: bool = true
@export var keycardRequired: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	door_collider.disabled = false
	slide_door_anim.play('RESET')

func _on_area_2d_body_entered(body: Node2D) -> void:
	if locked or not body is PlayerController:
		return
	#door_collider.disabled = true
	#if slide_door_anim.is_playing():
		#return
	slide_door_anim.play("open")
	await slide_door_anim.animation_finished
	disable_collider()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if locked or not body is PlayerController:
		return
	#door_collider.disabled = false
	#if slide_door_anim.is_playing():
		#return
	slide_door_anim.play("close")
	await slide_door_anim.animation_finished
	enable_collider()

func disable_collider():
	door_collider.disabled = true

func enable_collider():
	door_collider.disabled = false

func unlock():
	if locked:
		if keycardRequired:
			if Globals.InventoryManager.found["keycard"]:
				locked = false
		else:
			locked = false
	_on_area_2d_body_entered(Globals.Player)
