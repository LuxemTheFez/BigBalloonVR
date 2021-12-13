extends Spatial
class_name Balloon3D

onready var pathToFollow = get_parent()
onready var AreaBalloon = $HitboxBallon
var hp = 100
var speed = 30


func _ready():
	print("ready")

func _process(delta):
	MovementLoop(delta)


func MovementLoop(delta):

	pathToFollow.set_offset(pathToFollow.get_offset() + speed * delta)



func _on_HitboxBallon_area_shape_entered(area_id, area, area_shape, local_shape):
	print("area shape : ")
	print(area.get_parent().name)
	if(area.get_parent().name == "dagueRight" or area.get_parent().name == "dagueLeft"):
		print("aie")


func _on_HitboxBallon_area_shape_exited(area_id, area, area_shape, local_shape):
	pass # Replace with function body.
