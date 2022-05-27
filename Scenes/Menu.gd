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
		true,
		false,
		false
	]
}

func _ready():
	if not OS.is_debug_build(): OS.window_fullscreen = true
	OS.vsync_enabled = true
	Global.reload_settings()

func _process(_delta):
	# Start, Select, and LT + RT actions
	var event = Input
	
	if event.is_action_pressed("controller_start"):
		_on_Play_pressed()
		if debug_mode: print("_on_Play_pressed triggered")
	elif event.is_action_pressed("controller_rt") && event.is_action_pressed("controller_lt"):
		_on_Quit_pressed()
		if debug_mode: print("_on_Quit_pressed triggered")
	elif event.is_action_pressed("controller_select"):
		_on_Settings_pressed()
		if debug_mode: print("_on_Settings_pressed triggered")
		
	if event.is_action_just_pressed("down"):
		if array_object["bools"][0] == true:
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
		if array_object["bools"][0] == true:
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

func _on_Play_pressed():
	Global.game_start()


func _on_Quit_pressed():
	Global.quit_game()


func _on_Settings_pressed():
	Global.open_settings()
