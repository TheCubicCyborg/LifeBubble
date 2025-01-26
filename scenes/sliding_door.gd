extends Area2D


@export var door_collider : CollisionShape2D
@export var slide_door_anim : AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	door_collider.disabled = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if slide_door_anim.is_playing():
		return
	#slide_door_anim.play("open")
	door_collider.disabled = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if slide_door_anim.is_playing():
		return
	#slide_door_anim.play("close")
	door_collider.disabled = false
