extends Node

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
