extends Node

var debug_mode:bool = OS.is_debug_build()
var bool_size:int = 0
var node_size:int = 0

func _ready():
	reload_settings()
	pause_mode = Node.PAUSE_MODE_PROCESS
	print(OS.get_name())
	
func game_start():
	get_tree().change_scene("res://Scenes/Level-Select.tscn")

func quit_game():
	get_tree().quit()

func open_settings():
	get_tree().change_scene("res://Scenes/UIs/Settings.tscn")
	
func press_button_with_controller(array_object, parent):
	for j in array_object.nodes.size():
		if array_object["bools"][j] == true:
			parent.get_node(array_object["nodes"][j]).emit_signal("pressed")
	
func reload_menu_selection(array_object, parent):
	bool_size = array_object["bools"].size()-1
	node_size = array_object["nodes"].size()-1
	for i in array_object.nodes.size():
		if array_object.bools[i] == true: parent.get_node(array_object.nodes[i]).theme = load("res://Assets/Boxes/Box_Selected.tres")
		else: parent.get_node(array_object.nodes[i]).theme = load("res://Assets/Boxes/Box_Unselected.tres")
		
		if debug_mode:
			print(i, "Loading node:", array_object["nodes"][i])
			
func change_selection(array_object, dir:String, parent):
	if reload_for_controller(array_object, parent) == true:
		reload_for_controller(array_object, parent)
	elif (dir == "up" or dir == "left") and reload_for_controller(array_object, parent) == false:
		reload_menu_selection_up(array_object)
	elif (dir == "down" or dir == "right") and reload_for_controller(array_object, parent) == false:
		reload_menu_selection_down(array_object)
		
	reload_menu_selection(array_object, parent)


func reload_for_controller(array_object, parent):
	var count = 0
	for j in array_object["bools"].size():
		if array_object["bools"][j] == true:
			count += 1

	if count == 0:
		array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, parent)
		return true
	return false

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

func writeToFile(filename:String, content:String):
	var fileToWrite = File.new()
	print(content)
	fileToWrite.open("user://" + filename, File.WRITE)
	fileToWrite.store_string(content)
	fileToWrite.close()
	
func loadFromFile(filename:String):
	var fileToOpen = File.new()
	if not fileToOpen.file_exists("user://" + filename):
		if filename == "framerate.cfg": fileToOpen.store_string("60")
		else: fileToOpen.store_string("false")
	fileToOpen.open("user://" + filename, File.READ)
	var returnContent = fileToOpen.get_as_text()
	fileToOpen.close()
	return returnContent

func fileDoesExist(filename:String):
	var file = File.new()
	return file.file_exists("user://" + filename)

func reload_settings():
	var fullscreen:bool
	var vsync:bool
	var FPS:int = int(loadFromFile("framerate.cfg"))
	
	if loadFromFile("fullscreen.cfg") == "False":
		fullscreen = false
	if loadFromFile("fullscreen.cfg") == "True":
		fullscreen = true
		
	if loadFromFile("vsync.cfg") == "False":
		vsync = false
	if loadFromFile("vsync.cfg") == "True":
		vsync = true
		
	Engine.target_fps = FPS
	OS.window_fullscreen = fullscreen
	OS.vsync_enabled = vsync
	
	if OS.is_debug_build():
		print("FullScreen: " + String(fullscreen))
		print("VSync: " + String(vsync))
		print("FPS: " + String(FPS))

func clear_settings():
	writeToFile("fullscreen.cfg", "false")
	writeToFile("vsync.cfg", "false")
	writeToFile("framerate.cfg", "60")
	
func _process(_delta):
	var event = Input
	
	if event.is_action_just_pressed("controller_select") and not get_tree().current_scene.name == "Menu":
		if get_tree().paused == false: get_tree().paused = true
		elif get_tree().paused == true: get_tree().paused = false
		
		else: 
			if debug_mode:
				print("Error occured")
				
	elif event.is_action_pressed("controller_rt") && event.is_action_pressed("controller_lt"):
		quit_game()
		if debug_mode: print("_on_Quit_pressed triggered")
		

