extends Camera2D

export var enemy:bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	$Left.hide()
	$Jump.hide()
	$Right.hide()
	$Shoot.hide()
	if OS.get_name() == "Android":
		$Left.show()
		$Jump.show()
		$Right.show()
		$Shoot.show()
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	if get_parent().get_node("Player").movementAllowed: self.position.x = get_parent().get_node("Player").position.x


func _on_Area2D_area_entered(area):
	if not area.enemy: area.queue_free()


func _on_Area2D2_area_entered(area):
	if not area.enemy: area.queue_free()
