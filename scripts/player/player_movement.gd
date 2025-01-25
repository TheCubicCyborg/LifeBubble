extends CharacterBody2D


@export_group("player movement")
@export var player_speed : float = 10.0
@export var input_smoothing_factor : float = 1.0
@export var rotation_smoothing_factor : float = 1.0
@export var default_facing_dir := Vector2.ZERO

@onready var input : Vector2 = Vector2.ZERO
@onready var inputted : bool = false;
@onready var moving : bool = false;
@onready var direction_facing := 0.0

@export_group("children")
@export var collision_shape : CollisionShape2D

func _ready() -> void:
	collision_shape = $CollisionShape2D
	# when spawned: face collider/sprite towards direction of movement (
	#collision_shape.rotate(
		#rotate_toward(collision_shape.rotation, bruh, 1)
	#)
	if !default_facing_dir.is_zero_approx():
		direction_facing = default_facing_dir.angle()
		collision_shape.rotation = direction_facing

func _physics_process(delta: float) -> void:
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	moving = input != Vector2.ZERO
	
	if input != Vector2.ZERO:
		# TODO animate player
		# TODO face the player sprite in the direction of movement
		var normd = input.normalized()
		velocity = velocity.lerp(player_speed * normd, delta * input_smoothing_factor)
		#collision_shape.look_at(normd) 	# LOOK AT IS A POINT # FIXME
		direction_facing = lerp(
			direction_facing, velocity.angle(), delta * rotation_smoothing_factor
		)
		collision_shape.rotation = direction_facing
		#direction_facing = lerp(
			#collision_shape.rotation, normd.angle(), delta * rotation_smoothing_factor
		#)
		#collision_shape.rotation = direction_facing
		
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * input_smoothing_factor)
	
	move_and_slide()
