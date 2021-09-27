extends Node2D
class_name Balloon2D

onready var pathToFollow = get_parent()

var speed = 500

func _process(delta):
	$AnimatedSprite.rotation_degrees = -get_parent().rotation_degrees

func _physics_process(delta):
	MovementLoop(delta)

func MovementLoop(delta):
	var prepos = pathToFollow.get_global_position()
	pathToFollow.set_offset(pathToFollow.get_offset() + speed * delta)
	var pos = pathToFollow.get_global_position()
