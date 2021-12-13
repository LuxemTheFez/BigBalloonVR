extends Node2D
class_name Balloon2D

onready var pathToFollow = get_parent()

var speed = 300
var type = GlobalsBalloons.types.RED setget update
var color = Color(1,1,1,1)
var sprite = "res://Assets/balloon.png"
var damage = 0
var hp = 1
var float_advancement = 0
var last_float_offset = 0
var float_boundary = 5

func _ready():
	self.global_transform.origin.y -= float_boundary*2
	update(type)

func _process(delta):
	$Sprite.rotation_degrees = -get_parent().rotation_degrees
	var float_offset = sin(float_advancement)
	self.global_transform.origin.y += -last_float_offset + float_offset*float_boundary
	last_float_offset = float_offset*float_boundary
	float_advancement += 0.1

func _physics_process(delta):
	MovementLoop(delta)

func _input(event):
	if(event is InputEventMouseButton):
		if(event.pressed and not(event.is_echo())): #not(GlobalsBalloons.stopMouse)):
			if(get_local_mouse_position().length()<$Area2D2/CollisionShape2D.shape.radius):
				take_damage(1)
				GlobalsBalloons.stopMouse = true
				yield(get_tree().create_timer(1),"timeout")
				GlobalsBalloons.stopMouse = false

func MovementLoop(delta):
	var prepos = pathToFollow.get_global_position()
	pathToFollow.set_offset(pathToFollow.get_offset() + speed * delta)
	var pos = pathToFollow.get_global_position()

func update(value = GlobalsBalloons.types.RED):
	type = value
	speed = GlobalsBalloons.speed * GlobalsBalloons.getSpeed(value)
	color = GlobalsBalloons.getColor(value)
	sprite = GlobalsBalloons.getSprite(self)
	$Sprite.modulate = color
	$Sprite.texture = load(sprite)
	if(GlobalsBalloons.isZeppelin(value)):
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)

func take_damage(damage):
	hp-=damage
	if(hp <= 0):
		GlobalsBalloons.pop(self)
