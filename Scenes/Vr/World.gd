extends Spatial

onready var NODE_BALLOON3D = preload("res://Scenes/Both/Balloon3D.tscn")
onready var NODE_PLAYER = preload("res://Scenes/Vr/Player.tscn")
onready var NODE_FIN = preload("res://Scenes/Vr/3DFin.tscn")

onready var firstPath  = $Chemins/FirstPath
onready var secondPath = $Chemins/SecondPath
onready var thirdPath  = $Chemins/ThirdPath
onready var fourthPath = $Chemins/FourthPath



onready var healthBar = $Camera/Control/ProgressBar
onready var paths = [firstPath,secondPath,thirdPath,fourthPath]
var player
signal updatePv(number)
onready var idBalloon = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	player = NODE_PLAYER.instance()
	# To comment to play on editor
	add_child(player)
	player.transform.origin = Vector3(95, 0,0)
	randomize()
	Network.joinServer()
	Network.connect("spawnBalloon3D", self,"spawnBalloon")
	Network.connect("sendFinPartie", self, "fini")
	Network.connect("receiveKillSinge", self, "deleteSinge")

func spawnBalloon(typeChosen,pathChosen,idBalloon,offset):
	var balloon = NODE_BALLOON3D.instance()
	balloon.type = typeChosen
	balloon.hp = GlobalsBalloons.getHp(balloon.type)
	balloon.speed = (balloon.speed*GlobalsBalloons.getSpeed(typeChosen))/5.12
	var path = paths[pathChosen]
	var chosenPath = PathFollow.new()
	chosenPath.name = str(idBalloon)
	chosenPath.loop = false
	chosenPath.add_child(balloon)
	chosenPath.set_offset(offset)
	path.add_child(chosenPath)



func _on_House_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.get_parent().name == "Balloon3D"):
		area.get_parent().get_parent().queue_free()
		Network.sendKillBalloon(area.get_parent().get_parent().get_parent().name,area.get_parent().get_parent().name)
		Globals.hpVRMan-=GlobalsBalloons.getDamage(area.get_parent().type)
		Network.remoteUpdateHp(Globals.hpVRMan)
		emit_signal("updatePv", -GlobalsBalloons.getDamage(area.get_parent().type))
		

func updateHealth(value):
	healthBar.set_value(healthBar.get_value()+value)

func fini():
	var arrayPath = get_node("/root/Field/Chemins/").get_children()
	for path in arrayPath:
		for voie in path.get_children():
			voie.queue_free()
	var panneauFin = NODE_FIN.instance()
	panneauFin.name="fin"
	add_child(panneauFin)

func _on_Button_pressed():
	spawnBalloon(GlobalsBalloons.types.PINK,randi() % paths.size(),idBalloon, 0)
	idBalloon+=1

func deleteSinge(name):
	get_node(name).queue_free()
