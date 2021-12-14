extends Spatial
class_name Balloon3D

onready var pathToFollow = get_parent()
onready var AreaBalloon = $HitboxBallon

var hp 
var speed = 300
var type = GlobalsBalloons.types.RED setget update
var color = Color(1,1,1,1)
var sprite = "res://Assets/balloon.png"


func _ready():
	print("ready")

func _process(delta):
	MovementLoop(delta)


func MovementLoop(delta):
	pathToFollow.set_offset(pathToFollow.get_offset() + speed * delta)

func _init():
	hp=1

func _on_HitboxBallon_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.get_parent().name == "dagueRight" or area.get_parent().name == "dagueLeft"):
		print("aie balloon")
#		take_damage(1)
		rpc_id(1, "remotePop", self)

func take_damage(damage):
	hp-=damage
	if(hp <= 0):
		GlobalsBalloons.pop(self)

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
