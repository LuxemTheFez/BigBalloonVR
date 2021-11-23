extends Spatial

onready var NODE_BALLOON3D = preload("res://Scenes/Vr/Balloon3D.tscn")

onready var firstPath  = $Path1
onready var secondPath = $Path2
onready var thirdPath  = $Path3
onready var fourthPath = $Path4

onready var paths = [firstPath,secondPath,thirdPath,fourthPath]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func spawnBalloon():
	var balloon = NODE_BALLOON3D.instance()

	var path = paths[randi() % paths.size()]
	var chosenPath = PathFollow.new()
	chosenPath.loop = false
	chosenPath.add_child(balloon)
	chosenPath.set_offset(0)
	path.add_child(chosenPath)


func _process(delta):
	pass


func _on_House_area_shape_entered(area_id, area, area_shape, local_shape):

	if(area.get_parent().name == "Balloon3D"):
		print("aie")
		area.get_parent().queue_free()
		area.get_parent().get_parent().queue_free()



func _on_Button_pressed():
	print("prot")
	spawnBalloon()
