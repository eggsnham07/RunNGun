extends Node
class_name Mod

var MOD_NAME = "Unnamed Mod"
var LOADER_VER = 1.1

func _ready():
	print("[ModEngine]: Ready!")

func add_game_stats():
	Global.add_game_stats()

func enable_devmode():
	Global.debug_mode = true
	
func shoot_shots():
	get_parent().call_deferred("add_child", load("res://Scenes/Player/Projectile.tscn"))

func log_to_console(msg:String):
	print("[" + self.MOD_NAME + "]: " + msg)

func get_name():
	return MOD_NAME
	
func set_name(name:String):
	MOD_NAME = name
	return MOD_NAME
	
func get_version():
	return LOADER_VER
	
func set_version(ver:float):
	LOADER_VER = ver
	return LOADER_VER
