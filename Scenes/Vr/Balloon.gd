extends Spatial
class_name Balloon3D

onready var pathToFollow = get_parent()
onready var AreaBalloon = $Area

var speed = 30

#func _process(delta):
#	AreaBalloon.look_at()

func _ready():
	print("ready")

func _process(delta):
	MovementLoop(delta)


func MovementLoop(delta):

	pathToFollow.set_offset(pathToFollow.get_offset() + speed * delta)

