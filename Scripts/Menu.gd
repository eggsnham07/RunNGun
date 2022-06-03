extends Node2D

onready var debug_mode:bool = Global.debug_mode
onready var Play = $Play
onready var Quit = $Quit
onready var Settings = $Settings

onready var array_object = {
	"nodes": [
		"Play",
		"Settings",
		"Quit"
	],
	"bools": [
		false,
		false,
		false
	]
}

func _ready():
	if OS.is_debug_build(): 
		var stats = preload("res://Scenes/UIs/DevStats.tscn")
		OS.window_fullscreen = false
		get_parent().call_deferred(
			"add_child",
			stats.instance()
		)
		
	Global.reload_settings()
	Global.reload_menu_selection(array_object, self)	

func _process(_delta):
	# Start, Select, and LT + RT actions
	var event = Input
	
	if event.is_action_pressed("controller_start"):
		_on_Play_pressed()
		if debug_mode: print("_on_Play_pressed triggered")
	elif event.is_action_pressed("controller_select"):
		_on_Settings_pressed()
		if debug_mode: print("_on_Settings_pressed triggered")
		
	if event.is_action_just_pressed("down"):
		var count = 0
		for j in array_object["bools"].size():
			if array_object["bools"][j] == true:
				count += 1

		if count == 0:
			array_object["bools"][0] = true
			Global.reload_menu_selection(array_object, self)

		elif array_object["bools"][0] == true:
			array_object["bools"][0] = false
			array_object["bools"][1] = true
		elif array_object["bools"][1] == true:
			array_object["bools"][1] = false
			array_object["bools"][2] = true
		elif array_object["bools"][2] == true:
			array_object["bools"][2] = false
			array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, self)
		
		if debug_mode:
			print("Down action triggered")
			
	if event.is_action_just_pressed("up"):
		var count = 0
		for j in array_object["bools"].size():
			if array_object["bools"][j] == true:
				count += 1

		if count == 0:
			array_object["bools"][0] = true
			Global.reload_menu_selection(array_object, self)
			
		elif array_object["bools"][0] == true:
			array_object["bools"][0] = false
			array_object["bools"][2] = true
		elif array_object["bools"][2] == true:
			array_object["bools"][2] = false
			array_object["bools"][1] = true
		elif array_object["bools"][1] == true:
			array_object["bools"][1] = false
			array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, self)
		
		if debug_mode:
			print("Up action triggered")
			
	if event.is_action_just_pressed("jump"):
		for i in array_object.nodes.size():
			if array_object.bools[i]: get_node(array_object.nodes[i]).emit_signal("pressed")

func _on_Play_pressed():
	Global.game_start()


func _on_Quit_pressed():
	Global.quit_game()


func _on_Settings_pressed():
	Global.open_settings()


func _on_Load_Mod_pressed():
	var open_mod = preload("res://Scenes/UIs/SelectMod.tscn")
	self.add_child(open_mod.instance())
