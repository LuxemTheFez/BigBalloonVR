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
var color_step = 1.0

onready var button = $Panel/VBoxContainer/HBoxContainer/TextureButton
var step = 0

onready var imgPump0 = preload("res://Assets/pump/inflator-1.png")
onready var imgPump1 = preload("res://Assets/pump/inflator-2.png")
onready var imgPump2 = preload("res://Assets/pump/inflator-3.png")
onready var imgPump3 = preload("res://Assets/pump/inflator-4.png")
onready var imgsPump = [imgPump0,imgPump1,imgPump2,imgPump3]

var air = 0
var slowness = 30.0

func _ready():
	button.self_modulate = Color(0.93,0.07,00.7,1)
#	button.modulate.r = color_max_value/255.0
#	button.modulate.g = color_min_value/255.0
#	button.modulate.b = color_min_value/255.0
	fill_air()

func _process(delta):
	$Panel/VBoxContainer/ProgressBar.value = Globals.hpVRMan
	$Panel/VBoxContainer/HBoxContainer/TextureButton/ProgressBar.value = air
	
#	match step:
#		0:
#			button.modulate.b += color_step/255.0
#			if button.modulate.b >= color_max_value/255.0:
#				step +=1
#		1:
#			button.modulate.r -= color_step/255.0
#			if button.modulate.r <= color_min_value/255.0:
#				step += 1
#		2:
#			button.modulate.g += color_step/255.0
#			if button.modulate.g >= color_max_value/255.0:
#				step+=1
#		3:
#			button.modulate.b -= color_step/255.0
#			if button.modulate.b <= color_min_value/255.0:
#				step += 1
#		4:
#			button.modulate.r += color_step/255.0
#			if button.modulate.r >= color_max_value/255.0:
#				step +=1
#		5:
#			button.modulate.g -= color_step/255.0
#			if button.modulate.g > color_min_value/255.0:
#				step = 0

signal inflatorClicked()
func _on_TextureButton_pressed():
	if(air == 100):
		air = 0
		emit_signal("inflatorClicked")
		pump()

func pump():
	button.texture_normal = imgPump0
	yield(get_tree().create_timer(slowness/2000.0),"timeout")
	for i in range(1,4):
		print(i)
		button.texture_normal = imgsPump[i%4]
		yield(get_tree().create_timer(slowness/1000.0),"timeout")
	for i in range(2,-1,-1):
		print(i)
		button.texture_normal = imgsPump[i%4]
		yield(get_tree().create_timer(slowness/1000.0),"timeout")

func fill_air():
	while true:
		if air < 100:
			air += 1
		yield(get_tree().create_timer(slowness/1000.0),"timeout")
