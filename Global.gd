extends Node

var debug_mode:bool = OS.is_debug_build()

func _ready():
	reload_settings()
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func game_start():
	get_tree().change_scene("res://Scenes/Level-Select.tscn")

func quit_game():
	get_tree().quit()

func open_settings():
	get_tree().change_scene("res://Scenes/UIs/Settings.tscn")
	
func reload_menu_selection(array_object, parent):
	for i in array_object.nodes.size():
		if array_object.bools[i] == true: parent.get_node(array_object.nodes[i]).theme = load("res://Assets/Boxes/Box_Selected.tres")
		else: parent.get_node(array_object.nodes[i]).theme = load("res://Assets/Boxes/Box_Unselected.tres")
		
		if debug_mode:
			print(i)

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
