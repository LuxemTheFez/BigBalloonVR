extends Node2D

const NODE_BALLOON = preload("res://Scenes/Both/Balloon2D.tscn")

onready var firstPath  = $FirstPath
onready var secondPath = $SecondPath
onready var thirdPath  = $ThirdPath
onready var fourthPath = $FourthPath

onready var paths = [firstPath,secondPath,thirdPath,fourthPath]

func _ready():
	$CanvasLayer/MarginContainer/Control.connect("inflatorClicked",self,"createBalloon")

func createBalloon():
	var balloon = NODE_BALLOON.instance()
	randomize()
	var path = paths[randi() % paths.size()]
	var good_path = PathFollow2D.new()
	good_path.loop = false
	good_path.add_child(balloon)
	good_path.set_offset(0)
	path.add_child(good_path)

func _on_Area2D_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.get_parent().name == "Balloon2D"):
		Globals.hpVRMan -= 1
		if(area.get_parent().get_parent().get_child_count() == 1):
			area.get_parent().get_parent().
