extends ARVRController

var controller_velocity = Vector3(0,0,0)
var prior_controller_position = Vector3(0,0,0)
var prior_controller_velocities = []

const max_speed = 5.0
const min_speed = 2.0
onready var joueur = get_node("../..")

var armswinger_button 
var nbSinge = 3
onready var NODE_SINGE = preload("res://Scenes/Vr/Monkey/Monkey.scn")

var camera

var camera_transform

var armswinger_speeds = []

var velocity = Vector3(0.0, 0.0, 0.0)

var tabSpeed = []
var oldPos = null

enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}


func _ready():
	
	camera = get_node("../ARVRCamera")
	
	armswinger_button = Buttons.VR_GRIP

func _physics_process(delta):
	if get_is_active() == true:
		_physics_process_update_controller_velocity(delta)

func _physics_process_update_controller_velocity(delta):
	
	controller_velocity = Vector3(0,0,0)
	
	var curr_transform = joueur.global_transform
	
	var vitesse_moyenne = 0

	if is_button_pressed(armswinger_button):
		
		
		if oldPos==null:
			oldPos=self.translation.y
		else:

			var calcul = stepify((self.translation.y-oldPos)/delta, 0.01)

			tabSpeed.append(sqrt(pow(calcul,2)))
			oldPos = null

		if tabSpeed.size() > 2:
			tabSpeed.pop_front()
		
		
		vitesse_moyenne = moyenne(tabSpeed)
		



		var dir_forward = camera.rotation.y
		
		var vector = Vector3(-sin(dir_forward),0,-cos(dir_forward))
		velocity = vector * vitesse_moyenne * ARVRServer.world_scale *1.5

		#Check if the speed is lower than the minimum velocity, if it is, apply the minimum velocity instead

		

	#clear the armswinger speeds array otherwise the velocity will be remembered
	elif !is_button_pressed(armswinger_button):
		
		tabSpeed.clear()
		velocity = Vector3.ZERO
		oldPos = null

		
	joueur.move_and_slide(velocity, Vector3(0.0, 1.0, 0.0))
	
	if is_button_pressed(Buttons.VR_TRIGGER):
		var monkeyInstance = NODE_SINGE.instance()
		monkeyInstance.transform = joueur.transform
		monkeyInstance
		
func moyenne(tab: Array):
	var res = 0
	if tab.size()!=0:
		var compteur = 0
		for i in tab:
			compteur+=i
		res = compteur/tab.size()
	return res
