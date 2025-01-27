extends Control

var found:Dictionary
@export var item_textures:Dictionary
var selected: Vector2
var item_moves = [
	["crowbar"],
	["keycard", "notes"],
]
var item_outlines
var accepting_input:bool

#@export var main_inv : CanvasLayer
#@export var notes_list : CanvasLayer

@export var animation_player : AnimationPlayer

@onready var mainInv = $MainInv
@onready var notesList = $NotesList

@export var notes : Array[TextureRect]
@export var note_textures : Array[Texture]
@export var blank_texture : Texture

var selected_note := 0

var in_notes := false

# Called when the node enters the scene tree for the first time.
func _ready():
	in_notes = false
	selected_note = 0
	set_inv_visibility(false)
	for key in item_textures:
		get_node(item_textures[key]).visible = false
	populate_found()
	selected = Vector2(0,0)
	set_outline(arr_vect2(item_moves, selected))
	Globals.InventoryManager = self
	animation_player.play("RESET")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.Player.accepting_input and Input.is_action_just_pressed("inventory"):
		open_inventory()
	elif accepting_input and Input.is_action_just_pressed("inventory"):
		close_inventory()
	if accepting_input:
		var note_count = num_of_notes()
		if note_count > 0:
			%FocusPos.visible = true
		elif note_count > 1:
			%RightPos.visible = true
		elif note_count > 2:
			%LeftPos.visible = true
		if in_notes:
			if Input.is_action_just_pressed("escape"):
				exit_notes()
				return
			elif Input.is_action_just_pressed("interact"):
				pull_up_note(selected_note)
			elif Input.is_action_just_pressed("move_left"):
				selected_note = wrapi(selected_note + 1, 0, 5)
			elif Input.is_action_just_pressed("move_right"):
				selected_note = wrapi(selected_note - 1, 0, 5)
			display_notes()
			return
		var inputted = false
		if Input.is_action_just_pressed("move_up") and selected.y != 0: 
			selected.y -= 1
			inputted = true
		elif Input.is_action_just_pressed("move_right") and selected.x != len(item_moves) - 1: 
			selected.x += 1
			selected.y = 0
			inputted = true
		elif Input.is_action_just_pressed("move_down") and selected.y != len(item_moves[selected.x]) -1 and num_of_notes() > 0: 
			selected.y += 1
			inputted = true
		elif Input.is_action_just_pressed("move_left") and selected.x != 0 : 
			selected.x -= 1
			selected.y = 0
			inputted = true
		if inputted:
			print(arr_vect2(item_moves, selected))
			set_outline(arr_vect2(item_moves, selected))
		else:
			if Input.is_action_just_pressed("interact") and arr_vect2(item_moves, selected) == 'notes' and num_of_notes() > 0:
				bring_up_notes()

func pull_up_note(note_index: int) -> void:
	print("SELECT: ", selected_note)

func display_notes():
	%FocusPos.texture = note_textures[selected_note]
	if wrapi(selected_note - 1, 0, 5) in Globals.GameManager.notes_obtained:
		%LeftPos.texture = note_textures[wrapi(selected_note - 1, 0, 5)]
	else:
		%LeftPos.texture = blank_texture
	
	if wrapi(selected_note + 1, 0, 5) in Globals.GameManager.notes_obtained:
		%RightPos.texture = note_textures[wrapi(selected_note + 1, 0, 5)]
	else:
		%RightPos.texture = blank_texture
 	
func open_inventory():
	set_inv_visibility(true)
	Globals.Player.accepting_input = false
	accepting_input = true

func close_inventory():
	set_inv_visibility(false)
	accepting_input = false
	Globals.Player.accepting_input = true

func set_inv_visibility(isVisible):
	mainInv.visible = isVisible
	notesList.visible = isVisible

func set_outline(select:String):
	for key in item_textures:
		var mat = get_node(item_textures[key]).material
		mat.set_shader_parameter("width", 0)
	var sel_mat = get_node(item_textures[select]).material
	sel_mat.set_shader_parameter("width", 1)

func arr_vect2(arr:Array,vect2:Vector2):
	return arr[vect2.x][vect2.y]

func populate_found():
	for item in item_textures:
		found[item] = false

func bring_up_notes():
	animation_player.play('notes_in')
	in_notes = true
	
func exit_notes():
	animation_player.play('notes_out')
	in_notes = false

func pickup(item:String):
	found[item] = true
	get_node(item_textures[item]).visible = true

func num_of_notes() -> int:
	return len(Globals.GameManager.notes_obtained)
