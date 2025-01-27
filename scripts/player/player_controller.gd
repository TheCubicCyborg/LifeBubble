extends CharacterBody2D
class_name PlayerController

@export_group("player movement")
@export var _player_speed : float = 10.0
@export var _input_smoothing_factor : float = 1.0
@export var _rotation_smoothing_factor : float = 1.0
@export var _stop_threshold : float = 1.0
@export var _default_facing_dir := Vector2.ZERO

@onready var _input : Vector2 = Vector2.ZERO
@onready var _moving : bool = false;

# public
@onready var direction_facing := 0.0
@onready var accepting_input := true	# FIXME player should accept NO INPUT by default

@export_group("children")
@export var _collision_shape : CollisionShape2D
@export var _animator : AnimationPlayer

func _ready() -> void:
	# TODO assign a player variable in globals
	Globals.Player = self
	_collision_shape = $CollisionShape2D
	if !_default_facing_dir.is_zero_approx():
		direction_facing = _default_facing_dir.angle()
		_collision_shape.rotation = direction_facing

func _physics_process(delta: float) -> void:
	if accepting_input:
		_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	else:
		_animator.stop()
		_animator.queue("idle")
		return
	_moving = _input != Vector2.ZERO
	
	if _input != Vector2.ZERO:
		# TODO animate player
		# TODO face the player sprite in the direction of movement
		var normd = _input.normalized()
		velocity = velocity.lerp(_player_speed * normd, delta * _input_smoothing_factor)
		#direction_facing = lerp(
			#direction_facing, velocity.angle(), delta * _rotation_smoothing_factor
		#) # 
		direction_facing = lerp_angle(
			direction_facing, velocity.angle(), delta * _rotation_smoothing_factor
		)
		#direction_facing = velocity.angle()
		_collision_shape.rotation = direction_facing
		
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * _input_smoothing_factor)
	
	if velocity.length() < _stop_threshold:
		_animator.stop()
		_animator.queue("idle")
	else:
		_animator.play("walk")
	
	move_and_slide()

func set_accepting_input(accepting):
	accepting_input = accepting
