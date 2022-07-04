extends Node

var mods:PoolStringArray = []
var LOADER_VER = 1.1
var all_mods_loaded = false
var timer = null

export var extenalMods:PoolStringArray = []
	
func load_mods(data):
	var dir = Directory.new()
	dir.open("user://")
	
	if dir.dir_exists("mods"):
		mods = Global.list_files_in_directory("user://mods")
		for m in mods.size():
			if String(mods[m]).ends_with(".gd"):
				var error = preload("res://Scenes/UIs/PopupError.tscn").instance()
				
				if not load("user://mods/" + mods[m]).new().get("MOD_NAME"):
					error.get_node("Popup").set_size(Vector2(350, 80))
					error.get_node("Popup/Oops").text = "Mod: '" + mods[m] + "' is missing attribute:\n\nMOD_NAME"
					get_parent().call_deferred("add_child", error)
					
				if not load("user://mods/" + mods[m]).new().get("LOADER_VER"):
					print("Mod '" + mods[m].split(".gd")[0] + "' does not specify a loader version!\nIgnoring and using ver " + String(self.LOADER_VER))
					
				if load("user://mods/" + mods[m]).new().get("LOADER_VER"):
					if load("user://mods/" + mods[m]).new().LOADER_VER > self.LOADER_VER:
						error.get_node("Popup").set_size(Vector2(550, 80))
						error.get_node("Popup/Oops").text = "Mod: '" + mods[m] + "' is using a newer loader version: " + String(load("user://mods/" + mods[m]).new().LOADER_VER)
						error.get_node("Popup/Oops").text += "\n\nCurrent loader: " + String(self.LOADER_VER)
						get_parent().call_deferred("add_child", error)
				load("user://mods/" + mods[m]).new().main(data)
				print("Loaded mod: " + mods[m].split(".")[0])
			if m == mods.size()-1:
				print("[Mod Loader]: Done loading mods!")
				all_mods_loaded = true
