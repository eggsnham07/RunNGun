extends Control

var array_object = {
	"nodes": [
		"lvl1",
		"lvl2"
	],
	"bools": [
		false,
		false
	]
}
var debug_mode = Global.debug_mode

func _ready():
	Global.Player = null
	Global.reload_menu_selection(array_object, self)

func _process(_delta):
	var event = Input
	
	if event.is_action_just_pressed("controller_back"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
		
	if event.is_action_just_pressed("controller_left"):
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
			array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, self)
		
		if debug_mode:
			print("Down action triggered")
			
	if event.is_action_just_pressed("controller_right"):
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
			array_object["bools"][0] = true
		Global.reload_menu_selection(array_object, self)
		
		if debug_mode:
			print("Up action triggered")
			
	if event.is_action_just_pressed("controller_a"):
		for i in array_object.nodes.size():
			if array_object.bools[i]: get_node(array_object.nodes[i]).emit_signal("pressed")

func _on_lvl1_pressed():
	get_tree().change_scene("res://Scenes/Worlds/Level-01.tscn")


func _on_lvl2_pressed():
	get_tree().change_scene("res://Scenes/Worlds/Level-02.tscn")
