extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var user = ""
var viewData = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$SelectMod.hide()
	if OS.has_environment("USERNAME"):
		user = OS.get_environment("USERNAME")
	else:
		return (self_play_error(5))
		
	if($SelectMod.access == $SelectMod.ACCESS_FILESYSTEM):
		if OS.get_name() == "Windows":
			$SelectMod.current_dir = "C:/Users/" + user + "/Downloads"
		elif OS.get_name() == "X11":
			$SelectMod.current_dir = "/home/" + user + "/Downloads"
		elif OS.get_name() == "OSX":
			$SelectMod.current_dir = "/Users/" + user + "/Downloads"
		else:
			return(self_play_error(3))
			
		$SelectMod.filters = PoolStringArray(["*.gd; GD File"])
		
	elif($SelectMod.access == $SelectMod.ACCESS_USERDATA):
		$SelectMod.current_dir = "user://"
		viewData = true
		
	show_dialog()
	
func show_dialog():
	$SelectMod.show()
	$SelectMod.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func self_play_error(err_code:int):
	Global.play_error(self, err_code)
	if err_code == 1:
		$InvalidMod.popup()
	if err_code == 3:
		$SysNotSupported.popup()
	if err_code == 5:
		$NoModLoading.popup()

func _on_SelectMod_file_selected(path):
	var modContents = Global.loadFromFile(path)
	var dir = Directory.new()
	var filename = String(path).split("/")[String(path).split("/").size()-1]
	dir.open("user://")
	
	if not filename.ends_with(".gd"):
		return(self_play_error(1))
	print(path)
	if not dir.dir_exists("mods"):
		dir.make_dir("mods")
	if not viewData: Global.writeToFile("user://mods/" + filename, Global.loadFromFile(path))
	if not viewData: Global.writeToFile("user://logs/" + filename + ".log", "========Begin logging for " + filename + "========\n\n" + modContents)
	if viewData: print("============Begin Load of " + path + "============\n\n" + Global.loadFromFile(path) + "\n\n=============End Load of " + path + "=============")
	if not Global.fileDoesExist("loaded-mods.dat"):
		Global.writeToFile("user://loaded-mods.dat", filename)
	else:
		Global.writeToFile("user://loaded-mods.dat", Global.loadFromFile("loaded-mods.dat") + ":" + filename)
		
	ModLoader.load_mods()

func _on_SelectMod_confirmed():
	print($SelectMod.current_path)
	Global.writeToFile($SelectMod.current_file, Global.loadFromFile($SelectMod.current_path))
