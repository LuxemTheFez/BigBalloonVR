extends Spatial

onready var NODE_BALLOON3D = preload("res://Scenes/Both/Balloon3D.tscn")
onready var NODE_PLAYER = preload("res://Scenes/Vr/Player.tscn")

onready var firstPath  = $Chemins/Path1
onready var secondPath = $Chemins/Path2
onready var thirdPath  = $Chemins/Path3
onready var fourthPath = $Chemins/Path4
onready var healthBar = $Camera/Control/ProgressBar
onready var paths = [firstPath,secondPath,thirdPath,fourthPath]
var player
signal updatePv(number)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = NODE_PLAYER.instance()
	# To comment to play on editor
#	add_child(player)
	player.transform.origin = Vector3(95, 0,0)
	randomize()
	
func spawnBalloon():
	connect("updatePv", self, "updateHealth")
	var balloon = NODE_BALLOON3D.instance()
	balloon.type = GlobalsBalloons.types.PINK
	var path = paths[randi() % paths.size()]
	var chosenPath = PathFollow.new()
	chosenPath.loop = false
	chosenPath.add_child(balloon)
	chosenPath.set_offset(0)
	path.add_child(chosenPath)



func _on_House_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.get_parent().name == "Balloon3D"):
		print("aie")
		area.get_parent().queue_free()
		area.get_parent().get_parent().queue_free()
		print(GlobalsBalloons.getDamage(area.get_parent().type))
		emit_signal("updatePv", -GlobalsBalloons.getDamage(area.get_parent().type))
		

func updateHealth(value):
	healthBar.set_value(healthBar.get_value()+value)



func _on_Button_pressed():
	print("prot")
	spawnBalloon()
