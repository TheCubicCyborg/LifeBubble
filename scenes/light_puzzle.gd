extends Control

@export var buttons : Array[TextureRect]
@export var bulbs : Array[TextureRect]

@export var unlit_texture : Texture2D
@export var lit_texture : Texture2D

@export var animation_player : AnimationPlayer

@export var buttonUnpressed: Texture
@export var buttonPressed:Texture

var bulb_states = [false, false, false]
var button_index := 0

var press_timer: float
var press_length: float = 0.25
var pressed_button: int
var pressed:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for bulb in bulbs:
		bulb.texture = unlit_texture
	button_index = 0
	_set_selected_button(button_index)
	animation_player.play('RESET')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pressed and press_timer > 0:
		press_timer -= delta
	if pressed and press_timer <= 0:
		press_timer = 0
		buttons[pressed_button].texture = buttonUnpressed
		pressed = false
	
	
	if Input.is_action_just_pressed("interact"):
		activate(button_index)
	elif Input.is_action_just_pressed("move_down"):
		if button_index < 2:
			button_index += 1
			_set_selected_button(button_index)
	elif Input.is_action_just_pressed("move_up"):
		if button_index > 0:
			button_index -= 1
			_set_selected_button(button_index)
	
	if check_win():
		await get_tree().create_timer(1.0).timeout
		animation_player.play('FlyOut')
		await animation_player.animation_finished
		queue_free()

func check_win() -> bool:
	for bulb_state in bulb_states:
		if bulb_state == false:
			return false
	return true	
			
func activate(button_index: int) -> void:
	buttons[button_index].texture = buttonPressed
	press_timer = press_length
	pressed = true
	pressed_button = button_index
	if button_index == 0:
		change_bulb_state(0)
		change_bulb_state(2)
	elif button_index == 1:
		change_bulb_state(0)
	elif button_index == 2:
		change_bulb_state(0)
		change_bulb_state(1) 
	
func change_bulb_state(bulb_index: int) -> void:
	bulb_states[bulb_index] = not bulb_states[bulb_index]
	for i in range(3):
		if bulb_states[i] == true:
			bulbs[i].texture = lit_texture
		else:
			bulbs[i].texture = unlit_texture

func _set_selected_button(index) -> void:
	for button in buttons:
		var mat : ShaderMaterial = button.material
		mat.set_shader_parameter("width", 0)

	var mat : ShaderMaterial = buttons[index].material
	mat.set_shader_parameter("width", 1)
