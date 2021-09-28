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
var etape = 0

func _ready():
	button.modulate.r = color_max_value/255.0
	button.modulate.g = color_min_value/255.0
	button.modulate.b = color_min_value/255.0

func _process(delta):
	$Panel/VBoxContainer/ProgressBar.value = Globals.hpVRMan
	match etape:
		0:
			button.modulate.b += color_step/255.0
			if button.modulate.b >= color_max_value/255.0:
				etape +=1
		1:
			button.modulate.r -= color_step/255.0
			if button.modulate.r <= color_min_value/255.0:
				etape += 1
		2:
			button.modulate.g += color_step/255.0
			if button.modulate.g >= color_max_value/255.0:
				etape+=1
		3:
			button.modulate.b -= color_step/255.0
			if button.modulate.b <= color_min_value/255.0:
				etape += 1
		4:
			button.modulate.r += color_step/255.0
			if button.modulate.r >= color_max_value/255.0:
				etape +=1
		5:
			button.modulate.g -= color_step/255.0
			if button.modulate.g > color_min_value/255.0:
				etape = 0

signal inflatorClicked()
func _on_TextureButton_pressed():
	emit_signal("inflatorClicked")
