extends Control

# (200, 66, 245) purple
# (77, 79, 255) blue
# (77, 255, 228) turquoise
# (83, 230, 83) green
# (245, 242, 71) yellow
# (245, 174, 71) orange
# (245, 71, 71) red
# (245, 71, 202) pink

var color_min_value = 71.0
var color_max_value = 245.0

onready var button = $Panel/VBoxContainer/HBoxContainer/TextureButton
onready var progressHpVRMan = $Panel/VBoxContainer/ProgressHpVRMan
onready var progressBarAir = $Panel/VBoxContainer/HBoxContainer/TextureButton/HBoxContainer/TextureProgress
onready var labelAir = $Panel/VBoxContainer/HBoxContainer/TextureButton/HBoxContainer/LabelAir
onready var buttons = $Panel/VBoxContainer/HBoxContainer2

onready var imgPump0 = preload("res://Assets/pump/inflator-1.png")
onready var imgPump1 = preload("res://Assets/pump/inflator-2.png")
onready var imgPump2 = preload("res://Assets/pump/inflator-3.png")
onready var imgPump3 = preload("res://Assets/pump/inflator-4.png")
onready var imgsPump = [imgPump0,imgPump1,imgPump2,imgPump3]

onready var NODE_MONKEY = preload("res://Scenes/Mobile/Monkey/Monkey.tscn")

var air = 0
var air_max
var slowness
var auto = false

var typeBalloon
var pathSelected = 0

func _ready():
	GlobalsPump.connect("changeTypeBalloons",self,"changeTypeBalloons")
	GlobalsPump.connect("changeSlowness",self,"changeSlowness")
	GlobalsPump.connect("changeAir",self,"changeAir")
	GlobalsPump.connect("changeAirMax",self,"changeAirMax")
	Network.connect("updateHp", self, "updateHealth")
	slowness = GlobalsPump.slowness
	typeBalloon = GlobalsPump.typeBalloon
	air = GlobalsPump.air
	air_max = GlobalsPump.air_max
	button.self_modulate = GlobalsBalloons.getColor(typeBalloon)
	progressBarAir.tint_progress = GlobalsBalloons.getColor(typeBalloon)
	progressHpVRMan.value = Globals.hpVRMan
	add_monkey(-80,-45)
	
#	button.modulate.r = color_max_value/255.0
#	button.modulate.g = color_min_value/255.0
#	button.modulate.b = color_min_value/255.0
	fill_air()

func _process(delta):
	progressBarAir.value = air
	labelAir.text = str(int((float(air)/float(air_max))*100)) + "%"
	if(auto and air>=air_max):
		_on_TextureButton_pressed()

func updateHealth(health):
	if progressHpVRMan>0:
		progressHpVRMan.value = health
	else:
		Network.finPartie()
		get_tree().change_scene("res://Scenes/Mobile/fin2D.tscn")

func changeTypeBalloons(new_type):
	typeBalloon = new_type
	button.self_modulate = GlobalsBalloons.getColor(typeBalloon)
	progressBarAir.tint_progress = GlobalsBalloons.getColor(typeBalloon)

func changeSlowness(new_slowness):
	slowness = new_slowness

func changeAir(new_air):
	air = new_air

func changeAirMax(new_air_max):
	air_max = new_air_max
	if(new_air_max<air):
		air = new_air_max
	progressBarAir.max_value = new_air_max

signal inflatorClicked(type,path)
func _on_TextureButton_pressed():
	if(air >= air_max):
		air = 0
		emit_signal("inflatorClicked",typeBalloon,pathSelected)
		pump()
		

func pump():
	button.texture_normal = imgPump0
	yield(get_tree().create_timer(slowness/2000.0),"timeout")
	for i in range(1,4):
		button.texture_normal = imgsPump[i%4]
		yield(get_tree().create_timer(slowness/1000.0),"timeout")
	for i in range(2,-1,-1):
		button.texture_normal = imgsPump[i%4]
		yield(get_tree().create_timer(slowness/1000.0),"timeout")

func fill_air():
	while true:
		if air < air_max:
			air += 1
		yield(get_tree().create_timer(slowness/1000.0),"timeout")


func _on_UpgradePump_pressed():
	$Popup.popup()


func _on_AutoMode_pressed():
	auto = !auto

func _on_path_selected(number):
	#Va de 0 à 3 contrairement aux boutons donc -1
	pathSelected = number - 1
	for i in range(buttons.get_child_count()):
		if(i != pathSelected):
			buttons.get_child(i).pressed = false

func add_monkey(x,y):
	var monkey : Node2D = NODE_MONKEY.instance()
	monkey.transform.origin = Vector2(x*5.12,y*5.12)
	$Centre.add_child(monkey)
