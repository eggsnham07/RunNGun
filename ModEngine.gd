extends Node

func add_game_stats():
	var stats = preload("res://Scenes/UIs/DevStats.tscn")
	get_parent().call_deferred("add_child", stats.instance())

func enable_devmode():
	Global.debug_mode = true
	
func shoot_shots():
	get_parent().call_deferred("add_child", load("res://Scenes/Player/Projectile.tscn"))
