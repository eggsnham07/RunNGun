extends Area2D

onready var Sprite = $Projectile
export var reverse:bool = false
export var enemy:bool = false

func _physics_process(delta):
	Sprite.rotate(5 * delta)
	if reverse: position.x += 700 * delta
	else: position.x -= 700 * delta

func _on_Area2D_area_entered(area):
	if area.enemy:
		self.queue_free()
		area.die()
