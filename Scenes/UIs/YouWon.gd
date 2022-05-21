extends Control

func _ready():
	self.hide()

func _on_LevelSelect_pressed():
	get_tree().change_scene("res://Scenes/Level-Select.tscn")

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Retry_pressed():
	get_tree().reload_current_scene()
