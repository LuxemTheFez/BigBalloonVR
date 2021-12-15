extends Node2D

const NODE_BALLOON2D = preload("res://Scenes/Both/Balloon2D.tscn")

onready var firstPath  = $Chemins/FirstPath
onready var secondPath = $Chemins/SecondPath
onready var thirdPath  = $Chemins/ThirdPath
onready var fourthPath = $Chemins/FourthPath
onready var paths = [firstPath,secondPath,thirdPath,fourthPath]
onready var idBalloon = 0

func _ready():
	$CanvasLayer/MarginContainer/MainUI.connect("inflatorClicked",self,"createBalloon")
	Network.connect("killBallon",self,"killBalloon")

func createBalloon(type,path_nb):
	var balloon = NODE_BALLOON2D.instance()
	balloon.type = type
	randomize()
	var path = paths[path_nb]
	var good_path = PathFollow2D.new()
	good_path.name = str(idBalloon)
	Network.spawnBalloon(type,path_nb,idBalloon)
	idBalloon+=1
	good_path.loop = false
	good_path.add_child(balloon)
	good_path.set_offset(0)
	good_path.rotate = false
	path.add_child(good_path)

func _on_Area2D_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.get_parent().name == "Balloon2D"):
		Globals.hpVRMan -= GlobalsBalloons.getDamage(area.get_parent())
#		if(area.get_parent().get_parent().get_child_count() == 1):
#			area.get_parent().queue_free()
		area.get_parent().queue_free()

func killBalloon(parentPath,balloonId):
	get_node("/root/Field/Chemins/"+parentPath+"/"+balloonId+"").queue_free()
