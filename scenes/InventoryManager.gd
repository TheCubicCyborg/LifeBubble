extends Control

var found:Dictionary
@export var item_textures:Dictionary
var selected: Vector2
var item_moves = [
	["crowbar"],
	["keycard", "notes"],
]
var item_outlines

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_found()
	selected = Vector2(0,0)
	set_outline(arr_vect2(item_moves, selected))
	Globals.InventoryManager = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputted = false
	if Input.is_action_just_pressed("move_up") and selected.y != 0: 
		selected.y -= 1
		inputted = true
	elif Input.is_action_just_pressed("move_right") and selected.x != len(item_moves) - 1: 
		selected.x += 1
		selected.y = 0
		inputted = true
	elif Input.is_action_just_pressed("move_down") and selected.y != len(item_moves[selected.x]) -1 : 
		selected.y += 1
		inputted = true
	elif Input.is_action_just_pressed("move_left") and selected. x != 0 : 
		selected.x -= 1
		selected.y = 0
		inputted = true
	if inputted:
		print(arr_vect2(item_moves, selected))
		set_outline(arr_vect2(item_moves, selected))
			
func set_outline(select:String):
	for key in item_textures:
		var mat = get_node(item_textures[key]).material
		mat.set_shader_parameter("width", 0)
	var sel_mat = get_node(item_textures[select]).material
	sel_mat.set_shader_parameter("width", 3)

func arr_vect2(arr:Array,vect2:Vector2):
	return arr[vect2.x][vect2.y]

func populate_found():
	for item in item_textures:
		found[item] = false
