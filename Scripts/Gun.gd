extends Node2D

export var gun = "pistol"

onready var validGuns = {
	"names": [
		"pistol",
		"railgun"
	],
	"nodes": {
		"railgun": $RailGun,
		"pistol": $Pistol,
		"array": [
			$RailGun,
			$Pistol
		]
	}
}

func _ready():
	for i in validGuns["nodes"]["array"].size():
		if not validGuns["nodes"][gun] == validGuns["nodes"]["array"][i]: validGuns["nodes"]["array"][i].hide()
		
	render_gun_asset()

func pickup_gun(gun):
	if not validGuns.find(gun):
		return
	else:
		self.gun = gun

func render_gun_asset():
	if Global.debug_mode: print(gun)
	if gun == "railgun": validGuns["nodes"]["railgun"].show()
	if gun == "pistol": validGuns["nodes"]["pistol"].show()

func check_gun_type():
	if validGuns.names.find(gun):
		return true
	else:
		return false
