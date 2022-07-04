extends Control

func _ready():
	Global.Player = null

func _on_Knight_pressed():
	Global.writeToFile("user://skin.dat", "skin=knight")
	_on_Back_pressed()

func _on_Nerd_pressed():
	Global.writeToFile("user://skin.dat", "skin=nerd")
	_on_Back_pressed()

func _on_Monk_pressed():
	Global.writeToFile("user://skin.dat", "skin=monk")
	_on_Back_pressed()

func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
