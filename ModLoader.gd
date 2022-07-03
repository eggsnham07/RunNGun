extends Node

var mods:PoolStringArray = []

export var extenalMods:PoolStringArray = []

func _ready():
	load_mods()
	
func load_mods():
	var dir = Directory.new()
	dir.open("user://")
	
	if dir.dir_exists("mods"):
		mods = Global.list_files_in_directory("user://mods")
		for m in mods.size():
			load("user://mods/" + mods[m]).main()
			print("Loaded mod: " + mods[m].split(".")[0])
