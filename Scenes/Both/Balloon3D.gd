extends Spatial
class_name Balloon3D

onready var pathToFollow = get_parent()
onready var AreaBalloon = $HitboxBallon

var hp = 100
var speed = 100
var type = GlobalsBalloons.types.RED setget update
var color = Color(1,1,1,1)
var sprite = "res://Assets/balloon.png"


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
		rpc_id(1, "pop", get_parent().name)


func _on_HitboxBallon_area_shape_exited(area_id, area, area_shape, local_shape):
	pass # Replace with function body.

func update(value = GlobalsBalloons.types.RED):
	type = value
	speed = GlobalsBalloons.speed # * GlobalsBalloons.getSpeed(self)
	color = GlobalsBalloons.getColor(value)
	sprite = GlobalsBalloons.getSprite(self)
	$Sprite3D.material_override.albedo_color = color
	$Sprite3D.material_override.albedo_texture = load(sprite)
	$Sprite3D.texture = load(sprite)
	if(GlobalsBalloons.isZeppelin(value)):
		$Sprite3D.set_flip_h(true)
	else:
		$Sprite3D.set_flip_h(false)
