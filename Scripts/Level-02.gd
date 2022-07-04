extends Node2D

var count:int = 0

func _on_Enemy_died():
	count += 1

func _on_Enemy3_died():
	count += 1

func _on_Enemy2_died():
	count += 1

func _on_Enemy4_died():
	count += 1
	
func _process(_delta):
	if count == 4:
		get_node("PlayerCam/YouWon").show()
		get_node("PlayerCam/YouWon").hidden = false
