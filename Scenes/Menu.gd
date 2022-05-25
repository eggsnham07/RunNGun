extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not OS.is_debug_build(): OS.window_fullscreen = true
	OS.vsync_enabled = true
	Global.reload_settings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Level-Select.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/UIs/Settings.tscn")
