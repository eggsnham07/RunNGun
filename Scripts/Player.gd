extends KinematicBody2D

export var speed:int = 200
export var jumpForce:int = 600
export var playerGravity:int = 800
export var killable:bool = true
export var movementAllowed:bool = true

var velocity:Vector2 = Vector2()
var playerLevel:int = 0
var modifier:int = 2

onready var Body = $Body
onready var Gun = $Body/Gun
onready var Projectile = preload("res://Scenes/Player/Projectile.tscn")

func _ready():
	Global.Player = self

func _physics_process(delta):
	var proj = Projectile.instance()
	if Body.flip_h: modifier = -50
	else: modifier = 50
	velocity.y += playerGravity * delta
	velocity.x = 0
	
	if movementAllowed and Input.is_action_pressed("right"):
		velocity.x += speed
	if movementAllowed and Input.is_action_pressed("left"):
		velocity.x -= speed
	if movementAllowed and Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
		
	if movementAllowed and Input.is_action_pressed("down"):
		playerGravity = 2800
	elif movementAllowed and not Input.is_action_pressed("down"):
		playerGravity = 800
		
	if movementAllowed and Input.is_action_just_pressed("shoot"):
		var sfx = preload("res://Assets/SFX/Pew.tscn")
		get_parent().add_child(proj)
		get_parent().add_child(sfx.instance())
		proj.global_position.x = get_parent().get_node("Player/Body/Gun").global_position.x + modifier
		proj.global_position.y = get_parent().get_node("Player/Body/Gun").global_position.y
		if Body.flip_h == false: proj.reverse = true
		else: proj.reverse = false
		
	if movementAllowed and Input.is_action_pressed("sprint"):
		speed = 300
	if movementAllowed and not Input.is_action_pressed("sprint"):
		speed = 200
		
	
	if velocity.x > 0:
		Body.flip_h = false
		Gun.flip_h = false
		Gun.position.x = 9
		Gun.position.y = 2.8
	elif velocity.x < 0:
		Body.flip_h = true
		Gun.flip_h = true
		Gun.position.x = -9
		Gun.position.y = 2.8
	
	if velocity.x == 0:
		Body.play("default")
		Gun.play("default")
		if Body.flip_h == false: Gun.position.x = 4.4
		else: Gun.position.x = -4.4
		Gun.position.y = 6.8
	else:
		Body.play("Running")
		Gun.play("Running")
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
func die():
	if killable:
		movementAllowed = false
		position = Vector2(-900, -900)
		get_parent().get_node("PlayerCam/YouDied").show()
		get_parent().get_node("PlayerCam/YouDied").hidden = false
