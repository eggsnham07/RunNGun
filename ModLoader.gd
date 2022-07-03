extends Node

var mods:PoolStringArray = []

export var extenalMods:PoolStringArray = []
	
func load_mods(data):
	var dir = Directory.new()
	dir.open("user://")
	
	if dir.dir_exists("mods"):
		mods = Global.list_files_in_directory("user://mods")
		for m in mods.size():
			var error = preload("res://Scenes/UIs/PopupError.tscn").instance()
			
			if not load("user://mods/" + mods[m]).new().get("MOD_NAME"):
				error.get_node("Popup").set_size(Vector2(350, 80))
				error.get_node("Popup/Oops").text = "Mod: '" + mods[m] + "' is missing attribute:\n\nMOD_NAME"
				get_parent().call_deferred("add_child", error)
				
			if not load("user://mods/" + mods[m]).new().get("GAME_VER"):
				error.get_node("Popup").set_size(Vector2(350, 80))
				error.get_node("Popup/Oops").text = "Mod: '" + mods[m] + "' is missing attribute:\n\nGAME_VER"
				get_parent().call_deferred("add_child", error)
				
			if load("user://mods/" + mods[m]).new().get("GAME_VER") && not load("user://mods/" + mods[m]).new().GAME_VER == Global.GAME_VER:
				error.get_node("Popup").set_size(Vector2(475, 80))
				error.get_node("Popup/Oops").text = "[WARNING] Mod: '" + mods[m] + "' is outdated! mod version:\n" + String(load("user://mods/" + mods[m]).new().GAME_VER) + "\n[WARNING]: Mod may not work"
				get_parent().call_deferred("add_child", error)
			load("user://mods/" + mods[m]).new().main(data)
			print("Loaded mod: " + mods[m].split(".")[0])
			
			#DevStats.set_mods(String(m+1))
