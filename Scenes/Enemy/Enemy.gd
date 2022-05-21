extends Area2D

signal died

export var point1:int = 0
export var point2:int = 200
export var enemy:bool = true
export onready var animation:AnimatedSprite = $AnimatedSprite
var walkingBack:bool = false

func _physics_process(delta):
	$AnimatedSprite.flip_h = walkingBack
	if position.x <= point2 && walkingBack == false:
		position.x += 130 * delta
		
	if position.x >= point1 && walkingBack == true:
		position.x -= 130 * delta
		
	if position.x >= point2 and walkingBack == false: 
		walkingBack = true
	elif position.x <= point1 && walkingBack == true:
		walkingBack = false
	
func die():
	emit_signal("died")
	self.queue_free()


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
