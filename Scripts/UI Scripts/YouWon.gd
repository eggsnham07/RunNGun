extends Control

var array_object = {
	"nodes": [
		"LevelSelect",
		"Quit"
	],
	"bools": [
		false,	
		false
	]
}

var hidden:bool = true

func _ready():
	self.hide()
	Global.reload_menu_selection(array_object, self)
	
func _process(_delta):
	if not hidden:
		if Input.is_action_just_pressed("down"):
			Global.change_selection(array_object, "down", self)
			
		elif Input.is_action_just_pressed("down"):
			Global.change_selection(array_object, "down", self)
			
		if Input.is_action_just_pressed("jump"):
			Global.press_button_with_controller(array_object, self)
	

func _on_LevelSelect_pressed():
	get_tree().change_scene("res://Scenes/Level-Select.tscn")

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Retry_pressed():
	get_tree().reload_current_scene()

"""	
var node_size = array_object["nodes"].size()
var bool_size = array_object["bools"].size()

func change_selection(array_object, dir:String):
	if dir == "up" or dir == "left":
		reload_for_controller(array_object)
		reload_menu_selection_up(array_object)
	elif dir == "down" or dir == "right":
		reload_for_controller(array_object)
		reload_menu_selection_down(array_object)


func reload_for_controller(array_object):
	var count = 0
	for j in array_object["bools"].size():
		if array_object["bools"][j] == true:
			count += 1

	if count == 0:
		array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, self)

func reload_menu_selection_up(array_object):
	var current_size:int
	if array_object["bools"][0] == true:
		array_object["bools"][0] = false
		array_object["bools"][bool_size] = true
		current_size = -bool_size
	elif array_object["bools"][bool_size] == true:
		if bool_size-1 == 0:
			array_object["bools"][bool_size] = false
			array_object["bools"][0] = true
			current_size = 0
		else:
			array_object["bools"][bool_size] = false
			array_object["bools"][bool_size-1] = true
			current_size = -1
	elif array_object["bools"][bool_size-1] == true:
		if bool_size-2 == 0:
			array_object["bools"][bool_size-1] = false
			array_object["bools"][0] = true
			current_size = 0
		else:
			array_object["bools"][bool_size-1] = false
			array_object["bools"][bool_size-2] = true
			current_size = -2
	elif array_object["bools"][bool_size-2] == true:
		if bool_size-3 == 0:
			array_object["bools"][bool_size-2] = false
			array_object["bools"][0] = true
			current_size = 0
		else:
			array_object["bools"][bool_size-2] = false
			array_object["bools"][bool_size-3] = true
			current_size = -3
	else:
		print("Reached end of max menu selectable with controller")
		array_object["bools"][bool_size+current_size] = false
		array_object["bools"][0] = true
		
func reload_menu_selection_down(array_object):
	if array_object["bools"][bool_size] == true:
		array_object["bools"][bool_size] = false
		array_object["bools"][0] = true
	elif array_object["bools"][0] == true:
		array_object["bools"][0] = false
		if 1 == bool_size:
			array_object["bools"][bool_size] = true
		else:
			array_object["bools"][1] = true
	elif array_object["bools"][1] == true:
		array_object["bools"][1] = false
		if 2 == bool_size:
			array_object["bools"][bool_size] = true
		else:
			array_object["bools"][2] = true
	elif array_object["bools"][2] == true:
		array_object["bools"][2] = false
		if 3 == bool_size:
			array_object["bools"][bool_size] = true
		else:
			array_object["bools"][3] = true
	else:
		print("Reached end of max menu selectable with controller")
		array_object[bool_size] == true
"""
