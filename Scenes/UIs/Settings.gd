extends Control
"""
	Settings page script
"""
onready var vsync = get_node("VSyncLabel/VSync")
onready var fullscreen = get_node("FSLabel/FullScreen")

func _ready():
	get_node("Framerate/FramerateInput").text = String(Global.loadFromFile("framerate.cfg"))
	vsync.pressed = OS.vsync_enabled
	fullscreen.pressed = OS.window_fullscreen
	
func _process(_delta):
	var event = Input
	if event.is_action_just_pressed("controller_back"):
		get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_VSync_toggled(button_pressed):
	Global.writeToFile("vsync.cfg", String(button_pressed))
	if Global.debug_mode:
		print("VSync Toggled: " + String(button_pressed))
		
	Global.reload_settings()

func _on_FullScreen_toggled(button_pressed):
	Global.writeToFile("fullscreen.cfg", String(button_pressed))
	if Global.debug_mode:
		print("Fullscreen Toggled: " + String(button_pressed))
		
	Global.reload_settings()

func _on_Update_pressed():
	Global.writeToFile("framerate.cfg", get_node("Framerate/FramerateInput").text)
	if Global.debug_mode:
		print(float(get_node("Framerate/FramerateInput").text))
		
	Global.reload_settings()


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Reset_pressed():
	Global.clear_settings()
