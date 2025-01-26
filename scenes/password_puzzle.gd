extends Control

@export var password:String
@onready var textLine = $LineEdit
@onready var doorButton = $TextureButton

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		close()


func launch():
	Globals.Player.set_accepting_input(false)
	visible = true

func close():
	visible = false
	Globals.Player.set_accepting_input(true)

func on_admit():
	print("Admit")
	textLine.visible = false
	doorButton.visible = true

func on_deny():
	print("Deny")
	textLine.clear()


func _on_line_edit_text_submitted(new_text):
	if new_text == password:
		on_admit()
	else:
		on_deny()

func _on_texture_button_pressed():
	Globals.GameManager.openLaboratory()
